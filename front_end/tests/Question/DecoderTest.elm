module Question.DecoderTest exposing (all)

import Expect
import Json.Decode as Decode
import Question
import Question.Encoder as Encoder
import Question.Fuzzer as Question
import Test exposing (Test, describe, fuzz)


all : Test
all =
    describe "Question.decoder"
        [ decoderTest
        ]


decoderTest : Test
decoderTest =
    let
        randomQuestion =
            Question.fuzzer
    in
    fuzz randomQuestion "decoder maps to a Question" <|
        \question ->
            let
                expectedQuestion =
                    Ok question

                actualQuestion =
                    question
                        |> Encoder.encode
                        |> Decode.decodeValue Question.decoder
            in
            Expect.equal expectedQuestion actualQuestion
