module Theme.DecoderTest exposing (all)

import Expect
import Fuzz
import Json.Decode as Decode
import Test exposing (Test, describe, fuzz)
import Theme
import Theme.Encoder as Encoder
import Theme.Fuzzer as Theme


all : Test
all =
    describe "Theme.decoder"
        [ decoderTest
        ]


decoderTest : Test
decoderTest =
    let
        randomTheme =
            Theme.fuzzer
    in
    fuzz randomTheme "decoder maps to a Theme" <|
        \theme ->
            let
                expectedTheme =
                    Ok theme

                actualTheme =
                    theme
                        |> Encoder.encode
                        |> Decode.decodeValue Theme.decoder
            in
            Expect.equal expectedTheme actualTheme
