module SurveyResultList.DecoderTest exposing (..)

import Expect
import Json.Decode as Decode
import SurveyResultList.Decoder
import SurveyResultList.Encoder
import SurveyResultList.Fuzzer
import SurveyResultList.Model exposing (SurveyResultList)
import Test exposing (Test, describe, fuzz, test)


decoderTests : Test
decoderTests =
    let
        surveyResultList =
            SurveyResultList.Fuzzer.fuzzer
    in
        describe "SurveyResultList.Decoder"
            [ fuzz surveyResultList "decoder maps to a SurveyResultList" <|
                \surveyResultList ->
                    surveyResultList
                        |> SurveyResultList.Encoder.encoder
                        |> Decode.decodeValue SurveyResultList.Decoder.decoder
                        |> Expect.equal (Ok surveyResultList)
            ]
