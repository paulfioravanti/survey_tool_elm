module MainTest exposing (suite)

import Config exposing (Config)
import Expect
import Fuzz exposing (Fuzzer)
import Fuzzer.Config as Config
import Fuzzer.Navigation.Location as Location
import Main
import Model exposing (Model)
import Navigation
import Routing.Utils
import Test exposing (Test, describe, fuzz2)


{-| NOTE: It's not currently possible to determine whether
functions are "the same", so the Cmd Msg in the second
tuple value cannot be tested. More info at:
http://package.elm-lang.org/packages/elm-lang/core/latest/Basics#==
-}
suite : Test
suite =
    let
        config =
            Config.fuzzer

        location =
            Location.fuzzer
    in
        describe "Main"
            [ initTest config location
            , subscriptionsTest config location
            ]


initTest : Fuzzer Config -> Fuzzer Navigation.Location -> Test
initTest config location =
    fuzz2 config location "init" <|
        \config location ->
            let
                rootLocation =
                    { location | pathname = "/" }

                model =
                    rootLocation
                        |> Routing.Utils.toRoute
                        |> Model.initialModel config
            in
                rootLocation
                    |> Main.init config
                    |> Tuple.first
                    |> Expect.equal model


subscriptionsTest : Fuzzer Config -> Fuzzer Navigation.Location -> Test
subscriptionsTest config location =
    fuzz2 config location "subscriptions" <|
        \config location ->
            let
                model =
                    { location | pathname = "/" }
                        |> Routing.Utils.toRoute
                        |> Model.initialModel config
            in
                model
                    |> Main.subscriptions
                    |> Expect.equal Sub.none
