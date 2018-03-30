module HelpersTests exposing (..)

import Expect
import Helpers
import Test exposing (Test, describe, test)


extractSurveyResultDetailIdTests : Test
extractSurveyResultDetailIdTests =
    describe "extractSurveyResultDetailId"
        [ test "returns Int id from URL" <|
            \() ->
                "/survey_results/10.json"
                    |> Helpers.extractSurveyResultDetailId
                    |> Expect.equal 10
        , test "returns Int 0 when no numerical id in URL" <|
            \() ->
                "/survey_results/abc.json"
                    |> Helpers.extractSurveyResultDetailId
                    |> Expect.equal 0
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
        ]
