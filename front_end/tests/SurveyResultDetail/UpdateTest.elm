module SurveyResultDetail.UpdateTest exposing (suite)

import Expect
import Fuzzer.Config as Config
import Fuzzer.SurveyResult as SurveyResult
import Http exposing (Error(NetworkError))
import Model exposing (Model)
import Msg exposing (Msg(SurveyResultMsg))
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
import Routing.Route exposing (Route(SurveyResultDetailRoute))
import SurveyResult.Msg exposing (Msg(FetchSurveyResult))
import SurveyResult.Utils as Utils
import Test exposing (Test, describe, fuzz2)
import Update


suite : Test
suite =
    let
        surveyResult =
            SurveyResult.fuzzer

        config =
            Config.fuzzer
    in
        describe "update when SurveyResultMsg msg sent"
            [ fuzz2
                config
                surveyResult
                """
                model surveyResultDetail is updated with a Failure when
                FetchSurveyResult request fails
                """
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
                            SurveyResultMsg
                                (FetchSurveyResult (Err NetworkError))
                    in
                        model
                            |> Update.update msg
                            |> Tuple.first
                            |> Expect.equal
                                { model
                                    | surveyResultDetail = Failure NetworkError
                                }
            , fuzz2
                config
                surveyResult
                """
                model surveyResultDetail is updated with a Success when
                FetchSurveyResult request succeeds
                """
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
                                NotRequested
                                Requesting

                        msg =
                            SurveyResultMsg
                                (FetchSurveyResult (Ok surveyResultDetail))
                    in
                        model
                            |> Update.update msg
                            |> Tuple.first
                            |> Expect.equal
                                { model
                                    | surveyResultDetail =
                                        Success surveyResultDetail
                                }
            ]
