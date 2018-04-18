module SurveyResultTest exposing (suite)

import Expect
import Fuzzer.SurveyResult as SurveyResult
import Json.Decode as Decode
import SurveyResult
import SurveyResult.Encoder as Encoder
import Test exposing (Test, describe, fuzz)


suite : Test
suite =
    describe "SurveyResult"
        [ decoderTests () ]


decoderTests : () -> Test
decoderTests () =
    let
        surveyResult =
            SurveyResult.fuzzer
    in
        describe "decoder"
            [ fuzz surveyResult "decoder maps to a SurveyResult" <|
                \surveyResult ->
                    surveyResult
                        |> Encoder.encoder
                        |> Decode.decodeValue SurveyResult.decoder
                        |> Expect.equal (Ok surveyResult)
            ]
