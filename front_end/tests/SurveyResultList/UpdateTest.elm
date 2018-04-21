module SurveyResultList.UpdateTest exposing (suite)

import Config exposing (Config)
import Expect
import Fuzz exposing (Fuzzer)
import Fuzzer.Config as Config
import Fuzzer.Locale as Locale
import Fuzzer.SurveyResultList as SurveyResultList
import Http exposing (Error(NetworkError))
import Locale exposing (Locale)
import Model exposing (Model)
import Msg exposing (Msg(SurveyResultListMsg))
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
import Route exposing (Route(ListSurveyResultsRoute))
import SurveyResultList.Msg exposing (Msg(FetchSurveyResultList))
import Test exposing (Test, describe, fuzz2, fuzz3)
import Update


suite : Test
suite =
    let
        config =
            Config.fuzzer

        locale =
            Locale.fuzzer
    in
        describe "update"
            [ fetchSurveyResultListFailureTest config locale
            , fetchSurveyResultListSuccessTest config locale
            ]


fetchSurveyResultListFailureTest : Fuzzer Config -> Fuzzer Locale -> Test
fetchSurveyResultListFailureTest config locale =
    describe "when SurveyResultListMsg FetchSurveyResultList request fails"
        [ fuzz2
            config
            locale
            "model surveyResultList is updated with a Failure"
            (\config locale ->
                let
                    model =
                        Model
                            config
                            locale
                            ListSurveyResultsRoute
                            NotRequested
                            Requesting

                    msg =
                        SurveyResultListMsg
                            (FetchSurveyResultList (Err NetworkError))
                in
                    model
                        |> Update.update msg
                        |> Tuple.first
                        |> Expect.equal
                            { model
                                | surveyResultList = Failure NetworkError
                            }
            )
        ]


fetchSurveyResultListSuccessTest : Fuzzer Config -> Fuzzer Locale -> Test
fetchSurveyResultListSuccessTest config locale =
    let
        surveyResultList =
            SurveyResultList.fuzzer
    in
        describe "SurveyResultListMsg FetchSurveyResultList request succeeds"
            [ fuzz3
                config
                locale
                surveyResultList
                "model surveyResultList is updated with a Success"
                (\config locale surveyResultList ->
                    let
                        model =
                            Model
                                config
                                locale
                                ListSurveyResultsRoute
                                NotRequested
                                Requesting

                        msg =
                            SurveyResultListMsg
                                (FetchSurveyResultList (Ok surveyResultList))
                    in
                        model
                            |> Update.update msg
                            |> Tuple.first
                            |> Expect.equal
                                { model
                                    | surveyResultList =
                                        Success surveyResultList
                                }
                )
            ]
