module SurveyResultList.DecoderTest exposing (decoderTests)

import Expect
import SurveyResultList.Fuzzer as SurveyResultList
import Json.Decode as Decode
import SurveyResultList.Decoder as Decoder
import SurveyResultList.Encoder as Encoder
import Test exposing (Test, describe, fuzz)


decoderTests : Test
decoderTests =
    let
        surveyResultList =
            SurveyResultList.fuzzer
    in
        describe "SurveyResultList.Decoder"
            [ fuzz surveyResultList "decoder maps to a SurveyResultList" <|
                \surveyResultList ->
                    surveyResultList
                        |> Encoder.encoder
                        |> Decode.decodeValue Decoder.decoder
                        |> Expect.equal (Ok surveyResultList)
            ]
