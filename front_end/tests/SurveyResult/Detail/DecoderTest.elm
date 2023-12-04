module SurveyResult.Detail.DecoderTest exposing (all)

import Expect
import Fuzz exposing (Fuzzer)
import Json.Decode as Decode
import SurveyResult.Detail.Decoder as SurveyResultDetail
import SurveyResult.Detail.Encoder as Encoder
import SurveyResult.Detail.Fuzzer as SurveyResultDetail
import SurveyResult.Model exposing (SurveyResult)
import Test exposing (Test, describe, fuzz2)


all : Test
all =
    describe "SurveyResult.Detail.decoder"
        [ decoderTest
        ]


decoderTest : Test
decoderTest =
    let
        randomId : Fuzzer Int
        randomId =
            Fuzz.int

        randomSurveyResultDetail : Fuzzer SurveyResult
        randomSurveyResultDetail =
            SurveyResultDetail.fuzzer
    in
    fuzz2
        randomId
        randomSurveyResultDetail
        "decoder maps to a detailed SurveyResult"
        (\intId surveyResultDetail ->
            let
                id : String
                id =
                    String.fromInt intId

                url : String
                url =
                    "/survey_results/" ++ id ++ ".json"

                surveyResultDetailWithIdInUrl : SurveyResult
                surveyResultDetailWithIdInUrl =
                    { surveyResultDetail | url = url }
            in
            surveyResultDetailWithIdInUrl
                |> Encoder.encode
                |> Decode.decodeValue SurveyResultDetail.decoder
                |> Expect.ok
        )
