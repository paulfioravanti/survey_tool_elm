module SurveyResultList.UpdateTest exposing (suite)

import Config exposing (Config)
import Expect
import Fuzz exposing (Fuzzer)
import Fuzzer.Config as Config
import Fuzzer.SurveyResultList as SurveyResultList
import Http exposing (Error(NetworkError))
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
import Routing.Route exposing (Route(ListSurveyResultsRoute))
import SurveyResultList.Msg exposing (Msg(FetchSurveyResultList))
import Test exposing (Test, describe, fuzz, fuzz2)
import Update


suite : Test
suite =
    let
        config =
            Config.fuzzer
    in
        describe "update"
            [ fetchSurveyResultListFailureTest config
            , fetchSurveyResultListSuccessTest config
            ]


fetchSurveyResultListFailureTest : Fuzzer Config -> Test
fetchSurveyResultListFailureTest config =
    describe "when SurveyResultListMsg FetchSurveyResultList request fails"
        [ fuzz config "model surveyResultList is updated with a Failure" <|
            \config ->
                let
                    model =
                        Model
                            config
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
        ]


fetchSurveyResultListSuccessTest : Fuzzer Config -> Test
fetchSurveyResultListSuccessTest config =
    let
        surveyResultList =
            SurveyResultList.fuzzer
    in
        describe "SurveyResultListMsg FetchSurveyResultList request succeeds"
            [ fuzz2
                config
                surveyResultList
                "model surveyResultList is updated with a Success"
              <|
                \config surveyResultList ->
                    let
                        model =
                            Model
                                config
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
            ]
