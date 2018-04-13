module SurveyResponse.UtilsTest exposing (suite)

import Dict exposing (Dict)
import Expect
import SurveyResponse.Model exposing (SurveyResponse)
import SurveyResponse.Utils as Utils
import Test exposing (Test, describe, test)


suite : Test
suite =
    describe "SurveyResponse.Utils"
        [ addValidResponseTests ()
        , averageScoreTests ()
        , respondentHistogramTests ()
        , sumResponseContentTests ()
        ]


addValidResponseTests : () -> Test
addValidResponseTests () =
    describe "addValidResponse"
        [ describe "when SurveyResponse responseContent is valid"
            [ test "adds 1 to the accumulator" <|
                \() ->
                    let
                        surveyResponse =
                            SurveyResponse 1 1 1 "2"
                    in
                        Utils.addValidResponse surveyResponse 1
                            |> Expect.equal 2
            ]
        , describe "when SurveyResponse responseContent is blank"
            [ test "returns the accumulator and does not add 1" <|
                \() ->
                    let
                        surveyResponse =
                            SurveyResponse 1 1 1 ""
                    in
                        Utils.addValidResponse surveyResponse 1
                            |> Expect.equal 1
            ]
        , describe "when SurveyResponse responseContent is 0"
            [ test "returns the accumulator and does not add 1" <|
                \() ->
                    let
                        surveyResponse =
                            SurveyResponse 1 1 1 "0"
                    in
                        Utils.addValidResponse surveyResponse 1
                            |> Expect.equal 1
            ]
        , describe "when SurveyResponse responseContent is negative"
            [ test "returns the accumulator and does not add 1" <|
                \() ->
                    let
                        surveyResponse =
                            SurveyResponse 1 1 1 "-1"
                    in
                        Utils.addValidResponse surveyResponse 1
                            |> Expect.equal 1
            ]
        , describe "when SurveyResponse responseContent is over max score"
            [ test "returns the accumulator and does not add 1" <|
                \() ->
                    let
                        surveyResponse =
                            SurveyResponse 1 1 1 "6"
                    in
                        Utils.addValidResponse surveyResponse 1
                            |> Expect.equal 1
            ]
        , describe "when SurveyResponse responseContent is not an integer value"
            [ test "returns the accumulator and does not add 1" <|
                \() ->
                    let
                        surveyResponse =
                            SurveyResponse 1 1 1 "invalid"
                    in
                        Utils.addValidResponse surveyResponse 1
                            |> Expect.equal 1
            ]
        ]


averageScoreTests : () -> Test
averageScoreTests () =
    describe "averageScore"
        [ describe
            "when SurveyResponse list contains valid responseContent values"
            [ test "sums all the values and rounds to two decimal points" <|
                \() ->
                    let
                        surveyResponses =
                            [ SurveyResponse 1 1 1 "5"
                            , SurveyResponse 2 1 2 "4"
                            , SurveyResponse 3 1 3 "4"
                            , SurveyResponse 4 1 4 "2"
                            , SurveyResponse 5 1 5 "1"
                            ]
                    in
                        Utils.averageScore surveyResponses
                            |> Expect.equal "3.20"
            ]
        , describe
            "when SurveyResponse list contains invalid responseContent values"
            [ test "sums all valid values and ignores invalid values" <|
                \() ->
                    let
                        surveyResponses =
                            [ SurveyResponse 1 1 1 "4"
                            , SurveyResponse 5 1 5 "4"
                            , SurveyResponse 2 1 2 ""
                            , SurveyResponse 4 1 4 "-1"
                            , SurveyResponse 2 1 2 "0"
                            , SurveyResponse 2 1 2 "6"
                            , SurveyResponse 3 1 3 "invalid"
                            ]
                    in
                        Utils.averageScore surveyResponses
                            |> Expect.equal "4.00"
            ]
        ]


respondentHistogramTests : () -> Test
respondentHistogramTests () =
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
        describe "respondentHistogram"
            [ test
                "creates a score/respondent histogram using only valid values"
                (\() ->
                    surveyResponses
                        |> Utils.respondentHistogram
                        |> Expect.equal histogram
                )
            ]


sumResponseContentTests : () -> Test
sumResponseContentTests () =
    let
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
    in
        describe "sumResponseContent"
            [ test
                "sums valid responseContent values, ignoring invalid values"
                (\() ->
                    surveyResponses
                        |> Utils.sumResponseContent
                        |> Expect.equal 10
                )
            ]
