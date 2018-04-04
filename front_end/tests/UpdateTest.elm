module UpdateTest exposing (suite)

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


suite : Test
suite =
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
                                config
                                ListSurveyResultsRoute
                                NotRequested
                                NotRequested
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
                                config
                                ListSurveyResultsRoute
                                NotRequested
                                Requesting
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
                                config
                                (SurveyResultDetailRoute "10")
                                NotRequested
                                Requesting
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
                                config
                                NotFoundRoute
                                NotRequested
                                Requesting
                    in
                        model
                            |> Update.update msg
                            |> Tuple.first
                            |> Expect.equal model
            ]
