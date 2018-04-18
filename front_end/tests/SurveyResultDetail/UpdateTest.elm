module SurveyResultDetail.UpdateTest exposing (suite)

import Config exposing (Config)
import Expect
import Fuzz exposing (Fuzzer)
import Fuzzer.Config as Config
import Fuzzer.SurveyResult as SurveyResult
import Http exposing (Error(NetworkError))
import Model exposing (Model)
import Msg exposing (Msg(SurveyResultDetailMsg))
import RemoteData
    exposing
        ( RemoteData
            ( Failure
            , NotRequested
            , Requesting
            , Success
            )
        )
import Result exposing (Result)
import Route exposing (Route(SurveyResultDetailRoute))
import SurveyResult.Model exposing (SurveyResult)
import SurveyResult.Utils as Utils
import SurveyResultDetail.Msg exposing (Msg(FetchSurveyResultDetail))
import Test exposing (Test, describe, fuzz2)
import Update


suite : Test
suite =
    let
        config =
            Config.fuzzer

        surveyResult =
            SurveyResult.fuzzer
    in
        describe "update"
            [ fetchSurveyResultFailureTest config surveyResult
            , fetchSurveyResultSuccessTest config surveyResult
            ]


fetchSurveyResultFailureTest : Fuzzer Config -> Fuzzer SurveyResult -> Test
fetchSurveyResultFailureTest config surveyResult =
    describe "when SurveyResultDetailMsg FetchSurveyResultDetail request fails"
        [ fuzz2
            config
            surveyResult
            "model surveyResultDetail is updated with a Failure"
          <|
            \config surveyResultDetail ->
                let
                    id =
                        surveyResultDetail.url
                            |> Utils.extractId

                    model =
                        Model
                            config
                            (SurveyResultDetailRoute id)
                            Requesting
                            NotRequested

                    msg =
                        SurveyResultDetailMsg
                            (FetchSurveyResultDetail (Err NetworkError))
                in
                    model
                        |> Update.update msg
                        |> Tuple.first
                        |> Expect.equal
                            { model
                                | surveyResultDetail = Failure NetworkError
                            }
        ]


fetchSurveyResultSuccessTest : Fuzzer Config -> Fuzzer SurveyResult -> Test
fetchSurveyResultSuccessTest config surveyResult =
    describe
        "when SurveyResultDetailMsg FetchSurveyResultDetail request succeeds"
        [ fuzz2
            config
            surveyResult
            "model surveyResultDetail is updated with a Success"
            (\config surveyResultDetail ->
                let
                    id =
                        surveyResultDetail.url
                            |> Utils.extractId

                    model =
                        Model
                            config
                            (SurveyResultDetailRoute id)
                            NotRequested
                            Requesting

                    msg =
                        SurveyResultDetailMsg
                            (FetchSurveyResultDetail (Ok surveyResultDetail))
                in
                    model
                        |> Update.update msg
                        |> Tuple.first
                        |> Expect.equal
                            { model
                                | surveyResultDetail =
                                    Success surveyResultDetail
                            }
            )
        ]
