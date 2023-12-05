module Theme.DecoderTest exposing (all)

import Encoder.Theme as Theme
import Expect
import Fuzz exposing (Fuzzer)
import Fuzzer.Theme as Theme
import Json.Decode as Decode exposing (Error)
import Test exposing (Test, describe, fuzz)
import Theme exposing (Theme)


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
                        |> Theme.encode
                        |> Decode.decodeValue Theme.decoder
            in
            Expect.equal expectedTheme actualTheme
