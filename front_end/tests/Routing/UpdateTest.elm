module Routing.UpdateTest exposing (suite)

import Expect
import Fuzzer.Config as Config
import Fuzzer.Navigation.Location as Location
import Fuzzer.Routing.Route as Route
import Model exposing (Model)
import Msg exposing (Msg(RoutingMsg))
import Routing.Msg exposing (Msg(ChangeLocation, OnLocationChange))
import Routing.Route exposing (Route(ListSurveyResultsRoute))
import Routing.Router as Router
import Test exposing (Test, describe, fuzz3, fuzz4)
import Update


suite : Test
suite =
    let
        config =
            Config.fuzzer

        route =
            Route.fuzzer

        newRoute =
            Route.fuzzer

        location =
            Location.fuzzer
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
            , fuzz4
                config
                route
                newRoute
                location
                "updates the model route on OnLocationChange message"
              <|
                \config route newRoute location ->
                    let
                        model =
                            Model.initialModel config route

                        newLocation =
                            { location | pathname = Router.toPath newRoute }

                        msg =
                            RoutingMsg (OnLocationChange newLocation)
                    in
                        model
                            |> Update.update msg
                            |> Tuple.first
                            |> Expect.equal
                                { model | route = newRoute }
            ]
