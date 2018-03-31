module SurveyResult.DecoderTest exposing (..)

import Expect
import Json.Decode as Decode
import SurveyResult.Decoder
import SurveyResult.Encoder
import SurveyResult.Fuzzer
import SurveyResult.Model exposing (SurveyResult)
import Test exposing (Test, describe, fuzz, test)


decoderTests : Test
decoderTests =
    describe "SurveyResult.Decoder"
        [ fuzz SurveyResult.Fuzzer.fuzzer "decoder maps to a SurveyResult" <|
            \surveyResult ->
                surveyResult
                    |> SurveyResult.Encoder.encoder
                    |> Decode.decodeValue SurveyResult.Decoder.decoder
                    |> Expect.equal (Ok surveyResult)
        ]
