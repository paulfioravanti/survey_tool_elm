module SurveyResult.DecoderTest exposing (decoderTests)

import Expect
import Fuzzer.SurveyResult as SurveyResult
import Json.Decode as Decode
import SurveyResult.Decoder as Decoder
import SurveyResult.Encoder as Encoder
import Test exposing (Test, describe, fuzz)


decoderTests : Test
decoderTests =
    let
        surveyResult =
            SurveyResult.fuzzer
    in
        describe "SurveyResult.Decoder"
            [ fuzz surveyResult "decoder maps to a SurveyResult" <|
                \surveyResult ->
                    surveyResult
                        |> Encoder.encoder
                        |> Decode.decodeValue Decoder.decoder
                        |> Expect.equal (Ok surveyResult)
            ]
