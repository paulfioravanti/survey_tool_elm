module SurveyResultList.Decoder.DecoderTest exposing (all)

import Expect
import Json.Decode as Decode
import SurveyResultList.Decoder as Decoder
import SurveyResultList.Encoder as Encoder
import SurveyResultList.Fuzzer as SurveyResultList
import Test exposing (Test, describe, fuzz)


all : Test
all =
    describe "SurveyResultList.decoder"
        [ decoderTest
        ]


decoderTest : Test
decoderTest =
    let
        randomSurveyResultList =
            SurveyResultList.fuzzer
    in
    describe "SurveyResultList.Decoder"
        [ fuzz randomSurveyResultList "decoder maps to a SurveyResultList" <|
            \surveyResultList ->
                let
                    expectedSurveyResultList =
                        Ok surveyResultList

                    actualSurveyResultList =
                        surveyResultList
                            |> Encoder.encode
                            |> Decode.decodeValue Decoder.decoder
                in
                Expect.equal expectedSurveyResultList actualSurveyResultList
        ]
