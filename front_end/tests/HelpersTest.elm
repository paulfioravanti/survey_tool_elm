module HelpersTest exposing (..)

import Expect
import Fuzz exposing (Fuzzer, float, string)
import Helpers
import Regex
import Test exposing (Test, describe, fuzz, test)


toFormattedPercentageTests : Test
toFormattedPercentageTests =
    describe "toFormattedPercentage"
        [ fuzz float "returns a rounded percentage string" <|
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
        [ fuzz string "removes .json from any string" <|
            \string ->
                string
                    |> Helpers.toSurveyResultDetailUrl
                    |> String.contains ".json"
                    |> not
                    |> Expect.true "Expected to not contain '.json'"
        ]
