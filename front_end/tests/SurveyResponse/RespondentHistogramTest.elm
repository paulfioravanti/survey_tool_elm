module SurveyResponse.RespondentHistogramTest exposing (all)

import Dict
import Expect
import SurveyResponse
import SurveyResponse.Model exposing (SurveyResponse)
import SurveyResponse.RespondentHistogram exposing (RespondentHistogram)
import Test exposing (Test, describe, test)


all : Test
all =
    describe "SurveyResponse.respondentHistogram"
        [ respondentHistogramForSingleQuestionTest
        ]


respondentHistogramForSingleQuestionTest : Test
respondentHistogramForSingleQuestionTest =
    let
        surveyResponsesForSingleQuestion : List SurveyResponse
        surveyResponsesForSingleQuestion =
            [ SurveyResponse 500 1 5 "1"
            , SurveyResponse 400 1 4 "2"
            , SurveyResponse 300 1 3 "3"
            , SurveyResponse 1100 1 11 "3"
            , SurveyResponse 200 1 2 "4"
            , SurveyResponse 900 1 9 "4"
            , SurveyResponse 1000 1 10 "4"
            , SurveyResponse 100 1 1 "5"
            , SurveyResponse 600 1 6 "5"
            , SurveyResponse 700 1 7 "5"
            , SurveyResponse 800 1 8 "5"
            , SurveyResponse 1200 1 12 "0"
            , SurveyResponse 1300 1 13 "-1"
            , SurveyResponse 1400 1 14 "6"
            , SurveyResponse 1500 1 15 "invalid"
            ]

        expectedHistogram : RespondentHistogram
        expectedHistogram =
            Dict.fromList
                [ ( "1", [ "5" ] )
                , ( "2", [ "4" ] )
                , ( "3", [ "11", "3" ] )
                , ( "4", [ "10", "9", "2" ] )
                , ( "5", [ "8", "7", "6", "1" ] )
                ]

        actualHistogram : RespondentHistogram
        actualHistogram =
            SurveyResponse.respondentHistogram surveyResponsesForSingleQuestion
    in
    describe "when given a list of responses, all concerning a single question"
        [ test
            """
            returns a histogram dict for each response and the respondent IDs
            that chose it
            """
            (\() ->
                Expect.equal expectedHistogram actualHistogram
            )
        ]
