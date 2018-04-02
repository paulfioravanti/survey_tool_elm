module UpdateTest exposing (updateTests)

import Expect
import Fuzzer.Config as Config
import Model exposing (Model)
import Msg exposing (Msg(UpdatePage))
import RemoteData exposing (RemoteData(NotRequested, Requesting))
import Routing.Route
    exposing
        ( Route
            ( ListSurveyResultsRoute
            , NotFoundRoute
            , SurveyResultDetailRoute
            )
        )
import Test exposing (Test, describe, fuzz)
import Update


updateTests : Test
updateTests =
    let
        config =
            Config.fuzzer

        msg =
            UpdatePage ()
    in
        describe "update when UpdatePage msg sent"
            [ fuzz
                config
                """
                when the route is ListSurveyResultsRoute, it updates the
                surveyResultsList to Requesting when it is NotRequested.
                """
              <|
                \config ->
                    let
                        model =
                            Model
                                NotRequested
                                config
                                ListSurveyResultsRoute
                    in
                        model
                            |> Update.update msg
                            |> Tuple.first
                            |> Expect.equal
                                { model | surveyResultList = Requesting }
            , fuzz
                config
                """
                when the route is ListSurveyResultsRoute, it does not update the
                model if surveyResultsList has already been requested
                (ie it is not NotRequested).
                """
              <|
                \config ->
                    let
                        model =
                            Model
                                Requesting
                                config
                                ListSurveyResultsRoute
                    in
                        model
                            |> Update.update msg
                            |> Tuple.first
                            |> Expect.equal model
            , fuzz
                config
                """
                when the route is SurveyResultDetailRoute, it does not update
                the model.
                """
              <|
                \config ->
                    let
                        model =
                            Model
                                Requesting
                                config
                                (SurveyResultDetailRoute "10")
                    in
                        model
                            |> Update.update msg
                            |> Tuple.first
                            |> Expect.equal model
            , fuzz
                config
                """
                when the route is none of the above routes, it does not update
                the model.
                """
              <|
                \config ->
                    let
                        model =
                            Model
                                Requesting
                                config
                                NotFoundRoute
                    in
                        model
                            |> Update.update msg
                            |> Tuple.first
                            |> Expect.equal model
            ]
