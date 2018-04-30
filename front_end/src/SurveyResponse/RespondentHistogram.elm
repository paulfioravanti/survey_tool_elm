module SurveyResponse.RespondentHistogram
    exposing
        ( RespondentHistogram
        , init
        )

import Dict exposing (Dict)
import SurveyResponse.Model exposing (Rating, RespondentId, SurveyResponse)


{-| A histogram of response scores and the respondent IDs who chose them.
-}
type alias RespondentHistogram =
    Dict Rating (List RespondentId)


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

    histogram : RespondentHistogram
    histogram =
        Dict.fromList
            [ ( "1", [5] )
            , ( "2", [4] )
            , ( "3", [11, 3] )
            , ( "4", [10, 9, 2] )
            , ( "5", [8, 7, 6, 1] )
            ]

    init surveyResponses
    --> histogram

-}
init : List SurveyResponse -> RespondentHistogram
init surveyResponses =
    let
        prependRatingToList { respondentId, responseContent } histogram =
            if Dict.member responseContent histogram then
                histogram
                    |> Dict.update
                        responseContent
                        (Maybe.map ((::) respondentId))
            else
                histogram
    in
        List.foldl prependRatingToList initialHistogram surveyResponses


initialHistogram : RespondentHistogram
initialHistogram =
    Dict.fromList
        [ ( "1", [] )
        , ( "2", [] )
        , ( "3", [] )
        , ( "4", [] )
        , ( "5", [] )
        ]
