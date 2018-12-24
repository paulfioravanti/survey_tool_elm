module SurveyResponse.DecoderTest exposing (all)

import Expect
import Json.Decode as Decode
import SurveyResponse
import SurveyResponse.Encoder as Encoder
import SurveyResponse.Fuzzer as SurveyResponse
import Test exposing (Test, describe, fuzz)


all : Test
all =
    describe "SurveyResponse.decoder"
        [ decoderTest
        ]


decoderTest : Test
decoderTest =
    let
        randomSurveyResponse =
            SurveyResponse.fuzzer
    in
    fuzz randomSurveyResponse "decoder maps to a SurveyResponse" <|
        \surveyResponse ->
            let
                expectedSurveyResponse =
                    Ok surveyResponse

                actualSurveyResponse =
                    surveyResponse
                        |> Encoder.encode
                        |> Decode.decodeValue SurveyResponse.decoder
            in
            Expect.equal expectedSurveyResponse actualSurveyResponse
