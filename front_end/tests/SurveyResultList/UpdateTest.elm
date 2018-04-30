module SurveyResultList.UpdateTest exposing (suite)

import Config exposing (Config)
import Expect
import Fuzz exposing (Fuzzer)
import Fuzzer.Config as Config
import Fuzzer.Locale as Locale
import Fuzzer.Navigation.Location as Location
import Fuzzer.SurveyResultList as SurveyResultList
import Http exposing (Error(NetworkError))
import Locale exposing (Locale)
import Model exposing (Model)
import Msg exposing (Msg(SurveyResultListMsg))
import Navigation exposing (Location)
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
import Test exposing (Test, describe, fuzz3, fuzz4)
import Update


suite : Test
suite =
    let
        config =
            Config.fuzzer

        locale =
            Locale.fuzzer

        location =
            Location.fuzzer
    in
        describe "update"
            [ fetchSurveyResultListFailureTest config locale location
            , fetchSurveyResultListSuccessTest config locale location
            ]


fetchSurveyResultListFailureTest :
    Fuzzer Config
    -> Fuzzer Locale
    -> Fuzzer Location
    -> Test
fetchSurveyResultListFailureTest config locale location =
    describe "when SurveyResultListMsg FetchSurveyResultList request fails"
        [ fuzz3
            config
            locale
            location
            "model surveyResultList is updated with a Failure"
            (\config locale location ->
                let
                    model =
                        Model
                            config
                            locale
                            location
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


fetchSurveyResultListSuccessTest :
    Fuzzer Config
    -> Fuzzer Locale
    -> Fuzzer Location
    -> Test
fetchSurveyResultListSuccessTest config locale location =
    let
        surveyResultList =
            SurveyResultList.fuzzer
    in
        describe "SurveyResultListMsg FetchSurveyResultList request succeeds"
            [ fuzz4
                config
                locale
                location
                surveyResultList
                "model surveyResultList is updated with a Success"
                (\config locale location surveyResultList ->
                    let
                        model =
                            Model
                                config
                                locale
                                location
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
