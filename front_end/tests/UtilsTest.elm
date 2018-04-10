module UtilsTest exposing (toFormattedPercentageTests)

import Expect
import Fuzz exposing (Fuzzer, float)
import Utils
import Test exposing (Test, describe, fuzz)


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
                        |> Utils.toFormattedPercentage
                        |> Expect.equal formattedPercentage
        ]
