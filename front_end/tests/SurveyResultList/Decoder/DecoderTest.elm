module SurveyResultList.Decoder.DecoderTest exposing (all)

import Encoder.SurveyResultList as SurveyResultList
import Expect
import Fuzz exposing (Fuzzer)
import Fuzzer.SurveyResultList as SurveyResultList
import Json.Decode as Decode
import SurveyResultList exposing (SurveyResultList)
import SurveyResultList.Decoder as Decoder
import Test exposing (Test, describe, fuzz)


all : Test
all =
    describe "SurveyResultList.decoder"
        [ decoderTest
        ]


decoderTest : Test
decoderTest =
    let
        randomSurveyResultList : Fuzzer SurveyResultList
        randomSurveyResultList =
            SurveyResultList.fuzzer
    in
    describe "SurveyResultList.Decoder"
        [ fuzz randomSurveyResultList "decoder maps to a SurveyResultList" <|
            \surveyResultList ->
                surveyResultList
                    |> SurveyResultList.encode
                    |> Decode.decodeValue Decoder.decoder
                    |> Expect.ok
        ]
