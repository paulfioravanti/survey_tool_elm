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
import Navigation exposing (Location)
import RemoteData exposing (RemoteData(NotRequested))
import Route exposing (Route(ListSurveyResults))
import Router.Msg exposing (Msg(ChangeLocation))
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

        location =
            Location.fuzzer

        route =
            Route.fuzzer

        newRoute =
            Route.fuzzer
    in
        describe "update"
            [ changeLocationTest config locale location route newRoute
              -- , blurTest config locale route
              -- , onLocationChangeTest config locale route newRoute
            ]


changeLocationTest :
    Fuzzer Config
    -> Fuzzer Locale
    -> Fuzzer Location
    -> Fuzzer Route
    -> Fuzzer Route
    -> Test
changeLocationTest config locale location route newRoute =
    describe "when msg is ChangeLocation"
        [ fuzz5
            config
            locale
            location
            route
            newRoute
            "updates the model route"
            (\config locale location route newRoute ->
                let
                    model =
                        Model
                            config
                            locale
                            location
                            route
                            NotRequested
                            NotRequested

                    msg =
                        RoutingMsg (ChangeLocation newRoute)
                in
                    model
                        |> Update.update msg
                        |> Tuple.first
                        |> Expect.equal { model | route = newRoute }
            )
        ]
