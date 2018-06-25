module SurveyResponse.Utils
    exposing
        ( addValidResponse
        , averageScore
        , sumResponseContent
        )

{-| Utility functions for survey responses
-}

import Round
import SurveyResponse.Model exposing (Rating, SurveyResponse)


{-| Adds the integer value of a survey response's responseContent value
to an accumulator, `acc`.

Only valid `responseContent` values between values 1-5 add one to the
accumulator.

    import SurveyResponse.Model exposing (SurveyResponse)

    surveyResponse : String -> SurveyResponse
    surveyResponse responseContent =
        SurveyResponse 1 1 1 responseContent

    addValidResponse (surveyResponse "2") 1
    --> 2

    addValidResponse (surveyResponse "") 1
    --> 1

    addValidResponse (surveyResponse "0") 1
    --> 1

    addValidResponse (surveyResponse "-1") 1
    --> 1

    addValidResponse (surveyResponse "6") 1
    --> 1

    addValidResponse (surveyResponse "invalid") 1
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

    averageScore validSurveyResponses
    --> "3.20"

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
            \surveyResponse acc ->
                surveyResponse.responseContent
                    |> toIntValue
                    |> (+) acc
    in
        surveyResponses
            |> List.foldl addResponseContent 0


countValidResponses : List SurveyResponse -> Int
countValidResponses surveyResponses =
    surveyResponses
        |> List.foldl addValidResponse 0


toIntValue : Rating -> Int
toIntValue rating =
    let
        score =
            rating
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
