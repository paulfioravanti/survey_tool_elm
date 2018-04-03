module SurveyResultList.DecoderTest exposing (suite)

import Expect
import Fuzzer.SurveyResultList as SurveyResultList
import Json.Decode as Decode
import SurveyResultList.Decoder as Decoder
import SurveyResultList.Encoder as Encoder
import Test exposing (Test, describe, fuzz)


suite : Test
suite =
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
