module Router.UpdateTest exposing (suite)

import Config exposing (Config)
import Expect
import Fuzz exposing (Fuzzer)
import Fuzzer.Config as Config
import Fuzzer.Navigation.Location as Location
import Fuzzer.Locale as Locale
import Fuzzer.Route as Route
import Locale exposing (Locale)
import Model exposing (Model)
import Msg exposing (Msg(RoutingMsg))
import Navigation
import Route exposing (Route(ListSurveyResultsRoute))
import Router.Msg exposing (Msg(Blur, ChangeLocation, OnLocationChange))
import Router.Utils as Utils
import Test exposing (Test, describe, fuzz3, fuzz4, fuzz5)
import Update


suite : Test
suite =
    let
        config =
            Config.fuzzer

        locale =
            Locale.fuzzer

        route =
            Route.fuzzer

        newRoute =
            Route.fuzzer
    in
        describe "update"
            [ changeLocationTest config locale route newRoute
            , blurTest config locale route
            , onLocationChangeTest config locale route newRoute
            ]


changeLocationTest :
    Fuzzer Config
    -> Fuzzer Locale
    -> Fuzzer Route
    -> Fuzzer Route
    -> Test
changeLocationTest config locale route newRoute =
    describe "when msg is ChangeLocation"
        [ fuzz4 config locale route newRoute "updates the model route" <|
            \config locale route newRoute ->
                let
                    model =
                        Model.initialModel config locale route

                    msg =
                        RoutingMsg (ChangeLocation newRoute)
                in
                    model
                        |> Update.update msg
                        |> Tuple.first
                        |> Expect.equal { model | route = newRoute }
        ]


blurTest : Fuzzer Config -> Fuzzer Locale -> Fuzzer Route -> Test
blurTest config locale route =
    describe "when msg is Blur"
        [ fuzz3 config locale route "no Cmd is run" <|
            \config locale route ->
                let
                    model =
                        Model.initialModel config locale route

                    msg =
                        RoutingMsg (Blur route)
                in
                    model
                        |> Update.update msg
                        |> Tuple.second
                        |> Expect.equal Cmd.none
        ]


onLocationChangeTest :
    Fuzzer Config
    -> Fuzzer Locale
    -> Fuzzer Route
    -> Fuzzer Route
    -> Test
onLocationChangeTest config locale route newRoute =
    let
        location =
            Location.fuzzer
    in
        describe "when msg is OnLocationChange"
            [ fuzz5 config
                locale
                route
                newRoute
                location
                "updates the model route"
                (\config locale route newRoute location ->
                    let
                        model =
                            Model.initialModel config locale route

                        newLocation =
                            { location | pathname = Utils.toPath newRoute }

                        msg =
                            RoutingMsg (OnLocationChange newLocation)
                    in
                        model
                            |> Update.update msg
                            |> Tuple.first
                            |> Expect.equal { model | route = newRoute }
                )
            ]
