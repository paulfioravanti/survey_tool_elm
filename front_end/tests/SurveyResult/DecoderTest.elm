module SurveyResult.DecoderTest exposing (all)

import Encoder.SurveyResult as SurveyResult
import Expect
import Fuzz exposing (Fuzzer)
import Fuzzer.SurveyResult as SurveyResult
import Json.Decode as Decode
import SurveyResult exposing (SurveyResult)
import Test exposing (Test, describe, fuzz2)


all : Test
all =
    describe "SurveyResult.decoder"
        [ decoderTest
        ]


decoderTest : Test
decoderTest =
    let
        randomId : Fuzzer Int
        randomId =
            Fuzz.int

        randomSurveyResult : Fuzzer SurveyResult
        randomSurveyResult =
            SurveyResult.fuzzer
    in
    fuzz2 randomId randomSurveyResult "decoder maps to a SurveyResult" <|
        \intId surveyResult ->
            let
                id : String
                id =
                    String.fromInt intId

                url : String
                url =
                    "/survey_results/" ++ id ++ ".json"

                surveyResultWithIdInUrl : SurveyResult
                surveyResultWithIdInUrl =
                    { surveyResult | url = url }
            in
            surveyResultWithIdInUrl
                |> SurveyResult.encode
                |> Decode.decodeValue SurveyResult.decoder
                |> Expect.ok
