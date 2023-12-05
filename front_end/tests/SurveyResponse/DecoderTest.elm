module SurveyResponse.DecoderTest exposing (all)

import Encoder.SurveyResponse as SurveyResponse
import Expect
import Fuzz exposing (Fuzzer)
import Fuzzer.SurveyResponse as SurveyResponse
import Json.Decode as Decode exposing (Error)
import SurveyResponse exposing (SurveyResponse)
import Test exposing (Test, describe, fuzz)


all : Test
all =
    describe "SurveyResponse.decoder"
        [ decoderTest
        ]


decoderTest : Test
decoderTest =
    let
        randomSurveyResponse : Fuzzer SurveyResponse
        randomSurveyResponse =
            SurveyResponse.fuzzer
    in
    fuzz randomSurveyResponse "decoder maps to a SurveyResponse" <|
        \surveyResponse ->
            let
                expectedSurveyResponse : Result Error SurveyResponse
                expectedSurveyResponse =
                    Ok surveyResponse

                actualSurveyResponse : Result Error SurveyResponse
                actualSurveyResponse =
                    surveyResponse
                        |> SurveyResponse.encode
                        |> Decode.decodeValue SurveyResponse.decoder
            in
            Expect.equal expectedSurveyResponse actualSurveyResponse
