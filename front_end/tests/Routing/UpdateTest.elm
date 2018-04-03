module Routing.UpdateTest exposing (updateTests)

import Expect
import Fuzzer.Config as Config
import Factory.Navigation.Location as Location
import Fuzzer.Routing.Route as Route
import Model exposing (Model)
import Msg exposing (Msg(RoutingMsg))
import Routing.Msg exposing (Msg(ChangeLocation, OnLocationChange))
import Routing.Route exposing (Route(ListSurveyResultsRoute))
import Routing.Router as Router
import Test exposing (Test, describe, fuzz3, fuzz4)
import Update


updateTests : Test
updateTests =
    let
        config =
            Config.fuzzer

        route =
            Route.fuzzer

        newRoute =
            Route.fuzzer
    in
        describe "update"
            [ fuzz3
                config
                route
                newRoute
                "updates the model route on ChangeLocation message"
              <|
                \config route newRoute ->
                    let
                        model =
                            Model.initialModel config route

                        msg =
                            RoutingMsg (ChangeLocation newRoute)
                    in
                        model
                            |> Update.update msg
                            |> Tuple.first
                            |> Expect.equal
                                { model | route = newRoute }
            , fuzz3
                config
                route
                newRoute
                "updates the model route on OnLocationChange message"
              <|
                \config route newRoute ->
                    let
                        model =
                            Model.initialModel config route

                        location =
                            newRoute
                                |> Router.toPath
                                |> Location.factory

                        msg =
                            RoutingMsg (OnLocationChange location)
                    in
                        model
                            |> Update.update msg
                            |> Tuple.first
                            |> Expect.equal
                                { model | route = newRoute }
            ]
