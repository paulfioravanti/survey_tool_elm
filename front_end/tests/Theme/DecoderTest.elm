module Theme.DecoderTest exposing (all)

import Expect
import Fuzz exposing (Fuzzer)
import Json.Decode as Decode exposing (Error)
import Test exposing (Test, describe, fuzz)
import Theme exposing (Theme)
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
        randomTheme : Fuzzer Theme
        randomTheme =
            Theme.fuzzer
    in
    fuzz randomTheme "decoder maps to a Theme" <|
        \theme ->
            let
                expectedTheme : Result Error Theme
                expectedTheme =
                    Ok theme

                actualTheme : Result Error Theme
                actualTheme =
                    theme
                        |> Encoder.encode
                        |> Decode.decodeValue Theme.decoder
            in
            Expect.equal expectedTheme actualTheme
