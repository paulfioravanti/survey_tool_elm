module Utils.PercentFromFloatTest exposing (all)

import Expect
import Fuzz exposing (Fuzzer, float)
import Test exposing (Test, describe, fuzz, test)
import Utils


all : Test
all =
    describe "Utils.percentFromFloat"
        [ percentFromFloatTest
        , percentFromFloatRoundDownTest
        , percentFromFloatRoundUpTest
        ]


percentFromFloatTest : Test
percentFromFloatTest =
    let
        randomFloat =
            Fuzz.float
    in
    fuzz randomFloat "returns a rounded percentage string" <|
        \float ->
            let
                percentage =
                    float
                        * 100
                        |> round
                        |> String.fromInt

                expectedPercentage =
                    percentage ++ "%"

                actualPercentage =
                    Utils.percentFromFloat float
            in
            Expect.equal expectedPercentage actualPercentage


percentFromFloatRoundDownTest : Test
percentFromFloatRoundDownTest =
    let
        float =
            0.8333333333333334

        expectedPercentage =
            "83%"

        actualPercentage =
            Utils.percentFromFloat float
    in
    test "returns a rounded down percentage string" <|
        \() ->
            Expect.equal expectedPercentage actualPercentage


percentFromFloatRoundUpTest : Test
percentFromFloatRoundUpTest =
    let
        float =
            0.8366666666666664

        expectedPercentage =
            "84%"

        actualPercentage =
            Utils.percentFromFloat float
    in
    test "returns a rounded up percentage string" <|
        \() ->
            Expect.equal expectedPercentage actualPercentage
