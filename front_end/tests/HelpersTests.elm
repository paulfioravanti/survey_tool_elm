module HelpersTests exposing (..)

import Expect
import Fuzz exposing (Fuzzer, float, string)
import Helpers
import Regex
import Test exposing (Test, describe, fuzz, test)


extractSurveyResultDetailIdTests : Test
extractSurveyResultDetailIdTests =
    describe "extractSurveyResultDetailId"
        [ test "returns id from URL" <|
            \() ->
                "/survey_results/10.json"
                    |> Helpers.extractSurveyResultDetailId
                    |> Expect.equal "10"
        , test "makes no assumptions that id in URL is an integer" <|
            \() ->
                "/survey_results/abc.json"
                    |> Helpers.extractSurveyResultDetailId
                    |> Expect.equal "abc"
        ]


toFormattedPercentageTests : Test
toFormattedPercentageTests =
    describe "toFormattedPercentage"
        [ test "returns a rounded down number percentage string" <|
            \() ->
                0.8333333333333334
                    |> Helpers.toFormattedPercentage
                    |> Expect.equal "83%"
        , test "returns a rounded up number percentage string" <|
            \() ->
                0.8366666666666664
                    |> Helpers.toFormattedPercentage
                    |> Expect.equal "84%"
        , fuzz float "returns a rounded percentage string" <|
            \float ->
                let
                    percentage =
                        float
                            * 100
                            |> round
                            |> toString

                    formattedPercentage =
                        percentage ++ "%"
                in
                    float
                        |> Helpers.toFormattedPercentage
                        |> Expect.equal formattedPercentage
        ]


toSurveyResultDetailUrlTests : Test
toSurveyResultDetailUrlTests =
    describe "toSurveyResultDetailUrl"
        [ test "removes '.json' from a URL" <|
            \() ->
                "/survey_results/1.json"
                    |> Helpers.toSurveyResultDetailUrl
                    |> Expect.equal "/survey_results/1"
        , test "does nothing to a URL without '.json' in it" <|
            \() ->
                "/survey_results/1"
                    |> Helpers.toSurveyResultDetailUrl
                    |> Expect.equal "/survey_results/1"
        , fuzz string "removes .json from any string" <|
            \string ->
                "/survey_results/1"
                    |> Helpers.toSurveyResultDetailUrl
                    |> String.contains ".json"
                    |> not
                    |> Expect.true "Expected to not contain '.json'"
        ]
