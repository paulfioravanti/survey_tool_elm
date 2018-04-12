module SurveyResponse.Utils
    exposing
        ( addValidResponse
        , averageScore
        , respondentHistogram
        , sumResponseContent
        )

import Dict exposing (Dict)
import Round
import SurveyResponse.Model exposing (SurveyResponse)


{-| Adds the integer value of a survey response's responseContent value
to an accumulator, `acc`, if the responseContent value is valid.

    import SurveyResponse.Model exposing (SurveyResponse)

    validSurveyResponse : SurveyResponse
    validSurveyResponse =
        SurveyResponse 1 1 1 "2"

    invalidSurveyResponse1 : SurveyResponse
    invalidSurveyResponse1 =
        SurveyResponse 2 2 2 ""

    invalidSurveyResponse2 : SurveyResponse
    invalidSurveyResponse2 =
        SurveyResponse 2 2 2 "0"

    invalidSurveyResponse3 : SurveyResponse
    invalidSurveyResponse3 =
        SurveyResponse 2 2 2 "-1"

    invalidSurveyResponse4 : SurveyResponse
    invalidSurveyResponse4 =
        SurveyResponse 2 2 2 "6"

    invalidSurveyResponse5 : SurveyResponse
    invalidSurveyResponse5 =
        SurveyResponse 2 2 2 "invalid"

    addValidResponse validSurveyResponse 1
    --> 2

    addValidResponse invalidSurveyResponse1 1
    --> 1

    addValidResponse invalidSurveyResponse2 1
    --> 1

    addValidResponse invalidSurveyResponse3 1
    --> 1

    addValidResponse invalidSurveyResponse4 1
    --> 1

    addValidResponse invalidSurveyResponse5 1
    --> 1
-}
addValidResponse : SurveyResponse -> Int -> Int
addValidResponse surveyResponse acc =
    let
        score =
            surveyResponse.responseContent
                |> toIntValue
    in
        if isValidScore score then
            acc + 1
        else
            acc


{-| Tallies the `responseContent` values from a list of `SurveyResponses`
and returns an average score, rounded to two decimal places.

Only valid `responseContent` values between values 1-5 are counted in the tally.

    import SurveyResponse.Model exposing (SurveyResponse)

    validSurveyResponses : List SurveyResponse
    validSurveyResponses =
        [ SurveyResponse 1 1 1 "5"
        , SurveyResponse 2 1 2 "4"
        , SurveyResponse 3 1 3 "4"
        , SurveyResponse 4 1 4 "2"
        , SurveyResponse 5 1 5 "1"
        ]

    someInvalidSurveyResponses : List SurveyResponse
    someInvalidSurveyResponses =
        [ SurveyResponse 1 1 1 "4"
        , SurveyResponse 5 1 5 "4"
        , SurveyResponse 2 1 2 ""
        , SurveyResponse 4 1 4 "-1"
        , SurveyResponse 2 1 2 "0"
        , SurveyResponse 2 1 2 "6"
        , SurveyResponse 3 1 3 "invalid"
        ]

    averageScore validSurveyResponses
    --> "3.20"

    averageScore someInvalidSurveyResponses
    --> "4.00"
-}
averageScore : List SurveyResponse -> String
averageScore surveyResponses =
    let
        sum =
            surveyResponses
                |> sumResponseContent
                |> toFloat

        total =
            surveyResponses
                |> countValidResponses
                |> toFloat
    in
        total
            |> (/) sum
            |> Round.round 2


{-| Creates a histogram of survey respondents and their response scores for
a set of `SurveyResponses`. This is primarily used in the question tooltips,
where you want to know which respondents put down a particular score for a
question.

Only valid responses from 1-5 are included in the histogram.

    import Dict exposing (Dict)
    import SurveyResponse.Model exposing (SurveyResponse)

    surveyResponses : List SurveyResponse
    surveyResponses =
        [ SurveyResponse 100 1 1 "5"
        , SurveyResponse 600 1 6 "5"
        , SurveyResponse 700 1 7 "5"
        , SurveyResponse 800 1 8 "5"
        , SurveyResponse 200 1 2 "4"
        , SurveyResponse 900 1 9 "4"
        , SurveyResponse 1000 1 10 "4"
        , SurveyResponse 300 1 3 "3"
        , SurveyResponse 1100 1 11 "3"
        , SurveyResponse 400 1 4 "2"
        , SurveyResponse 500 1 5 "1"
        , SurveyResponse 1200 1 12 "0"
        , SurveyResponse 1300 1 13 "-1"
        , SurveyResponse 1400 1 14 "6"
        , SurveyResponse 1500 1 15 "invalid"
        ]

    histogram : Dict String (List Int)
    histogram =
        Dict.fromList
            [ ( "1", [5] )
            , ( "2", [4] )
            , ( "3", [11, 3] )
            , ( "4", [10, 9, 2] )
            , ( "5", [8, 7, 6, 1] )
            ]

    respondentHistogram surveyResponses
    --> histogram

-}
respondentHistogram : List SurveyResponse -> Dict String (List Int)
respondentHistogram surveyResponses =
    let
        histogram =
            Dict.fromList
                [ ( "1", [] )
                , ( "2", [] )
                , ( "3", [] )
                , ( "4", [] )
                , ( "5", [] )
                ]

        prependRatingToList { respondentId, responseContent } histogram =
            if Dict.member responseContent histogram then
                Dict.update
                    responseContent
                    (Maybe.map ((::) respondentId))
                    histogram
            else
                histogram
    in
        List.foldl prependRatingToList histogram surveyResponses


{-| Given a list of `SurveyResponse`s, takes the values in each of the
`responseContent` values and sums them.

Only valid responses from 1-5 are included in the sum.

    import SurveyResponse.Model exposing (SurveyResponse)

    surveyResponses : List SurveyResponse
    surveyResponses =
        [ SurveyResponse 1 1 1 "4"
        , SurveyResponse 5 1 5 "4"
        , SurveyResponse 6 1 6 "2"
        , SurveyResponse 8 1 8 ""
        , SurveyResponse 4 1 4 "-1"
        , SurveyResponse 2 1 2 "0"
        , SurveyResponse 7 1 7 "6"
        , SurveyResponse 3 1 3 "invalid"
        ]

    sumResponseContent surveyResponses
    --> 10
-}
sumResponseContent : List SurveyResponse -> Int
sumResponseContent surveyResponses =
    let
        addResponseContent =
            (\surveyResponse acc ->
                surveyResponse.responseContent
                    |> toIntValue
                    |> (+) acc
            )
    in
        surveyResponses
            |> List.foldl addResponseContent 0


countValidResponses : List SurveyResponse -> Int
countValidResponses surveyResponses =
    surveyResponses
        |> List.foldl addValidResponse 0


toIntValue : String -> Int
toIntValue responseContent =
    let
        score =
            responseContent
                |> String.toInt
                |> Result.withDefault 0
    in
        if isValidScore score then
            score
        else
            0


isValidScore : Int -> Bool
isValidScore score =
    if score > 0 && score < 6 then
        True
    else
        False
