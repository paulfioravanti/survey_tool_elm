module SurveyResponse.UtilsTest
    exposing
        ( addValidResponseTests
          -- , averageScoreTests
          -- , respondentHistogramTests
          -- , sumResponseContentTests
        )

import Expect
import Fuzz exposing (Fuzzer, float, string)
import SurveyResponse.Model exposing (SurveyResponse)
import SurveyResponse.Utils as Utils
import Test exposing (Test, describe, fuzz, test)


addValidResponseTests : Test
addValidResponseTests =
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
