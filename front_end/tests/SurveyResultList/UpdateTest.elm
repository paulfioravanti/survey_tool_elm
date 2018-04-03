module SurveyResultList.UpdateTest exposing (suite)

import Expect
import Fuzzer.Config as Config
import Fuzzer.SurveyResultList as SurveyResultList
import Http exposing (Error(NetworkError))
import Model exposing (Model)
import Msg exposing (Msg(SurveyResultListMsg))
import RemoteData exposing (RemoteData(Failure, Requesting, Success))
import Result exposing (Result)
import Routing.Route exposing (Route(ListSurveyResultsRoute))
import SurveyResultList.Msg exposing (Msg(FetchSurveyResultList))
import Test exposing (Test, describe, fuzz, fuzz2)
import Update


suite : Test
suite =
    let
        surveyResultList =
            SurveyResultList.fuzzer

        config =
            Config.fuzzer
    in
        describe "update when SurveyResultListMsg msg sent"
            [ fuzz
                config
                """
                model surveyResultList is updated with a Failure when
                FetchSurveyResultList request fails
                """
              <|
                \config ->
                    let
                        model =
                            Model
                                Requesting
                                config
                                ListSurveyResultsRoute

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
            , fuzz2
                config
                surveyResultList
                """
                model surveyResultList is updated with a Success when
                FetchSurveyResultList request succeeds
                """
              <|
                \config surveyResultList ->
                    let
                        model =
                            Model
                                Requesting
                                config
                                ListSurveyResultsRoute

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
