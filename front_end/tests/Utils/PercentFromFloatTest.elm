module Utils.PercentFromFloatTest exposing (all)

import Expect
import Fuzz exposing (Fuzzer)
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
        randomFloat : Fuzzer Float
        randomFloat =
            Fuzz.float
    in
    fuzz randomFloat "returns a rounded percentage string" <|
        \float ->
            let
                percentage : String
                percentage =
                    String.fromInt (round (float * 100))

                expectedPercentage : String
                expectedPercentage =
                    percentage ++ "%"

                actualPercentage : String
                actualPercentage =
                    Utils.percentFromFloat float
            in
            Expect.equal expectedPercentage actualPercentage


percentFromFloatRoundDownTest : Test
percentFromFloatRoundDownTest =
    let
        float : Float
        float =
            0.8333333333333334

        expectedPercentage : String
        expectedPercentage =
            "83%"

        actualPercentage : String
        actualPercentage =
            Utils.percentFromFloat float
    in
    test "returns a rounded down percentage string" <|
        \() ->
            Expect.equal expectedPercentage actualPercentage


percentFromFloatRoundUpTest : Test
percentFromFloatRoundUpTest =
    let
        float : Float
        float =
            0.8366666666666664

        expectedPercentage : String
        expectedPercentage =
            "84%"

        actualPercentage : String
        actualPercentage =
            Utils.percentFromFloat float
    in
    test "returns a rounded up percentage string" <|
        \() ->
            Expect.equal expectedPercentage actualPercentage
