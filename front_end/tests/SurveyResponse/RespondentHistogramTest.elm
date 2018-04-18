module SurveyResponse.RespondentHistogramTest exposing (suite)

import Dict exposing (Dict)
import Expect
import SurveyResponse.RespondentHistogram as RespondentHistogram
import SurveyResponse.Model exposing (SurveyResponse)
import Test exposing (Test, describe, test)


suite : Test
suite =
    describe "SurveyResponse.Histogram"
        [ fromSurveyResponseListTests ()
        ]


fromSurveyResponseListTests : () -> Test
fromSurveyResponseListTests () =
    let
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

        histogram =
            Dict.fromList
                [ ( "1", [ 5 ] )
                , ( "2", [ 4 ] )
                , ( "3", [ 11, 3 ] )
                , ( "4", [ 10, 9, 2 ] )
                , ( "5", [ 8, 7, 6, 1 ] )
                ]
    in
        describe "fromSurveyResponseList"
            [ test
                "creates a score/respondent histogram using only valid values"
                (\() ->
                    surveyResponses
                        |> RespondentHistogram.init
                        |> Expect.equal histogram
                )
            ]
