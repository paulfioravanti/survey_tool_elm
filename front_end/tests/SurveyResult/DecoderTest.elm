module SurveyResult.DecoderTest exposing (..)

import Expect
import Fuzz exposing (Fuzzer, float, int, list, string)
import Json.Decode as Decode
import Json.Encode as Encode
import SurveyResult.Decoder as Decoder
import SurveyResult.Model exposing (SurveyResult)
import Test exposing (Test, describe, fuzz5, test)


decoderTests : Test
decoderTests =
    describe "SurveyResult.Decoder"
        [ fuzz5 string int float int string "decoder maps to a SurveyList" <|
            \name participantCount responseRate submittedResponseCount url ->
                let
                    json =
                        Encode.object
                            [ ( "name"
                              , Encode.string name
                              )
                            , ( "participant_count"
                              , Encode.int participantCount
                              )
                            , ( "response_rate"
                              , Encode.float responseRate
                              )
                            , ( "submitted_response_count"
                              , Encode.int submittedResponseCount
                              )
                            , ( "url"
                              , Encode.string url
                              )
                            ]

                    surveyResult =
                        Ok
                            (SurveyResult
                                name
                                participantCount
                                responseRate
                                submittedResponseCount
                                url
                            )
                in
                    json
                        |> Decode.decodeValue Decoder.decoder
                        |> Expect.equal surveyResult
        ]
