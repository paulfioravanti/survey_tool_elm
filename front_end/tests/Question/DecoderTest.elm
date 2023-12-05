module Question.DecoderTest exposing (all)

import Encoder.Question as Encoder
import Expect
import Fuzz exposing (Fuzzer)
import Fuzzer.Question as Question
import Json.Decode as Decode exposing (Error)
import Question exposing (Question)
import Test exposing (Test, describe, fuzz)


all : Test
all =
    describe "Question.decoder"
        [ decoderTest
        ]


decoderTest : Test
decoderTest =
    let
        randomQuestion : Fuzzer Question
        randomQuestion =
            Question.fuzzer
    in
    fuzz randomQuestion "decoder maps to a Question" <|
        \question ->
            let
                expectedQuestion : Result Error Question
                expectedQuestion =
                    Ok question

                actualQuestion : Result Error Question
                actualQuestion =
                    question
                        |> Encoder.encode
                        |> Decode.decodeValue Question.decoder
            in
            Expect.equal expectedQuestion actualQuestion
