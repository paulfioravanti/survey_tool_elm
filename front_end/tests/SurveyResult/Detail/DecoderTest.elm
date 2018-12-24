module SurveyResult.Detail.DecoderTest exposing (all)

import Expect
import Fuzz
import Json.Decode as Decode
import SurveyResult.Detail.Decoder as SurveyResultDetail
import SurveyResult.Detail.Encoder as Encoder
import SurveyResult.Detail.Fuzzer as SurveyResultDetail
import Test exposing (Test, describe, fuzz2)


all : Test
all =
    describe "SurveyResult.Detail.decoder"
        [ decoderTest
        ]


decoderTest : Test
decoderTest =
    let
        randomId =
            Fuzz.int

        randomSurveyResultDetail =
            SurveyResultDetail.fuzzer
    in
    fuzz2
        randomId
        randomSurveyResultDetail
        "decoder maps to a detailed SurveyResult"
        (\intId surveyResultDetail ->
            let
                id =
                    String.fromInt intId

                url =
                    "/survey_results/" ++ id ++ ".json"

                surveyResultDetailWithIdInUrl =
                    { surveyResultDetail | url = url }

                expectedSurveyResultDetail =
                    Ok surveyResultDetailWithIdInUrl

                actualSurveyResultDetail =
                    surveyResultDetailWithIdInUrl
                        |> Encoder.encode
                        |> Decode.decodeValue SurveyResultDetail.decoder
            in
            Expect.equal expectedSurveyResultDetail actualSurveyResultDetail
        )
