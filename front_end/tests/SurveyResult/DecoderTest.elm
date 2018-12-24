module SurveyResult.DecoderTest exposing (all)

import Expect
import Fuzz
import Json.Decode as Decode
import SurveyResult
import SurveyResult.Encoder as Encoder
import SurveyResult.Fuzzer as SurveyResult
import Test exposing (Test, describe, fuzz2)


all : Test
all =
    describe "SurveyResult.decoder"
        [ decoderTest
        ]


decoderTest : Test
decoderTest =
    let
        randomId =
            Fuzz.int

        randomSurveyResult =
            SurveyResult.fuzzer
    in
    fuzz2 randomId randomSurveyResult "decoder maps to a SurveyResult" <|
        \intId surveyResult ->
            let
                id =
                    String.fromInt intId

                url =
                    "/survey_results/" ++ id ++ ".json"

                surveyResultWithIdInUrl =
                    { surveyResult | url = url }

                expectedSurveyResult =
                    Ok surveyResultWithIdInUrl

                actualSurveyResult =
                    surveyResultWithIdInUrl
                        |> Encoder.encode
                        |> Decode.decodeValue SurveyResult.decoder
            in
            Expect.equal expectedSurveyResult actualSurveyResult
