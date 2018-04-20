module Router.UpdateTest exposing (suite)

import Config exposing (Config)
import Expect
import Fuzz exposing (Fuzzer)
import Fuzzer.Config as Config
import Fuzzer.Navigation.Location as Location
import Fuzzer.Route as Route
import Locale exposing (Language(En))
import Model exposing (Model)
import Msg exposing (Msg(RoutingMsg))
import Navigation
import Route exposing (Route(ListSurveyResultsRoute))
import Router.Msg exposing (Msg(ChangeLocation, NoOp, OnLocationChange))
import Router.Utils as Utils
import Test exposing (Test, describe, fuzz2, fuzz3, fuzz4)
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
    in
        describe "update"
            [ changeLocationTest config route newRoute
            , noOpTest config route
            , onLocationChangeTest config route newRoute
            ]


changeLocationTest : Fuzzer Config -> Fuzzer Route -> Fuzzer Route -> Test
changeLocationTest config route newRoute =
    describe "when msg is ChangeLocation"
        [ fuzz3 config route newRoute "updates the model route" <|
            \config route newRoute ->
                let
                    model =
                        Model.initialModel config En route

                    msg =
                        RoutingMsg (ChangeLocation newRoute)
                in
                    model
                        |> Update.update msg
                        |> Tuple.first
                        |> Expect.equal { model | route = newRoute }
        ]


noOpTest : Fuzzer Config -> Fuzzer Route -> Test
noOpTest config route =
    describe "when msg is NoOp"
        [ fuzz2 config route "no Cmd is run" <|
            \config route ->
                let
                    model =
                        Model.initialModel config En route

                    msg =
                        RoutingMsg (NoOp route)
                in
                    model
                        |> Update.update msg
                        |> Tuple.second
                        |> Expect.equal Cmd.none
        ]


onLocationChangeTest : Fuzzer Config -> Fuzzer Route -> Fuzzer Route -> Test
onLocationChangeTest config route newRoute =
    let
        location =
            Location.fuzzer
    in
        describe "when msg is OnLocationChange"
            [ fuzz4 config route newRoute location "updates the model route" <|
                \config route newRoute location ->
                    let
                        model =
                            Model.initialModel config En route

                        newLocation =
                            { location | pathname = Utils.toPath newRoute }

                        msg =
                            RoutingMsg (OnLocationChange newLocation)
                    in
                        model
                            |> Update.update msg
                            |> Tuple.first
                            |> Expect.equal { model | route = newRoute }
            ]
