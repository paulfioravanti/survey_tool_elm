module SurveyResult.DecoderTest exposing (decoderTests)

import Expect
import Json.Decode as Decode
import SurveyResult.Decoder
import SurveyResult.Encoder
import SurveyResult.Fuzzer
import SurveyResult.Model exposing (SurveyResult)
import Test exposing (Test, describe, fuzz, test)


decoderTests : Test
decoderTests =
    let
        surveyResult =
            SurveyResult.Fuzzer.fuzzer
    in
        describe "SurveyResult.Decoder"
            [ fuzz surveyResult "decoder maps to a SurveyResult" <|
                \surveyResult ->
                    surveyResult
                        |> SurveyResult.Encoder.encoder
                        |> Decode.decodeValue SurveyResult.Decoder.decoder
                        |> Expect.equal (Ok surveyResult)
            ]
