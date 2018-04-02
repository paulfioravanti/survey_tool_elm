module SurveyResultList.UpdateTest exposing (updateTests)

import Expect
import Factory.Config as Config
import Http exposing (Error(NetworkError))
import Model exposing (Model)
import Msg exposing (Msg(SurveyResultListMsg))
import RemoteData exposing (RemoteData(Failure, Requesting, Success))
import Result exposing (Result)
import Routing.Route exposing (Route(ListSurveyResultsRoute))
import SurveyResultList.Fuzzer as SurveyResultList
import SurveyResultList.Msg exposing (Msg(FetchSurveyResultList))
import Test exposing (Test, describe, fuzz, test)
import Update


updateTests : Test
updateTests =
    let
        surveyResultList =
            SurveyResultList.fuzzer

        model =
            Model
                Requesting
                Config.factory
                ListSurveyResultsRoute
    in
        describe "update when SurveyResultListMsg msg sent"
            [ test
                """
                model surveyResultList is updated with a Failure when
                FetchSurveyResultList request fails
                """
              <|
                \() ->
                    let
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
            , fuzz
                surveyResultList
                """
                model surveyResultList is updated with a Success when
                FetchSurveyResultList request succeeds
                """
              <|
                \surveyResultList ->
                    let
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
