module HelpersTests exposing (..)

import Expect
import Fuzz exposing (Fuzzer, string)
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
        , fuzz string "extracts the id from the URL" <|
            \str ->
                let
                    id =
                        "/survey_results/"
                            ++ str
                            ++ ".json"
                            |> Helpers.extractSurveyResultDetailId
                in
                    if Regex.contains (Regex.regex "[^\\w\\d]+") str then
                        Expect.equal "" id
                    else
                        Expect.equal str id
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
