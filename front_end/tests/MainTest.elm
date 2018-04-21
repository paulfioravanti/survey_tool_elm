module MainTest exposing (suite)

import Config exposing (Config)
import Expect
import Flags exposing (Flags)
import Fuzz exposing (Fuzzer)
import Fuzzer.Flags as Flags
import Fuzzer.Navigation.Location as Location
import Locale
import Main
import Model exposing (Model)
import Navigation
import Router.Utils
import Test exposing (Test, describe, fuzz2)


{-| NOTE: It's not currently possible to determine whether
functions are "the same", so the Cmd Msg in the second
tuple value cannot be tested. More info at:
http://package.elm-lang.org/packages/elm-lang/core/latest/Basics#==
-}
suite : Test
suite =
    let
        flags =
            Flags.fuzzer

        location =
            Location.fuzzer
    in
        describe "Main"
            [ initTest flags location
            , subscriptionsTest flags location
            ]


initTest : Fuzzer Flags -> Fuzzer Navigation.Location -> Test
initTest flags location =
    fuzz2 flags location "init" <|
        \flags location ->
            let
                rootLocation =
                    { location | pathname = "/" }

                config =
                    Config.init flags

                locale =
                    Locale.init flags.language

                model =
                    rootLocation
                        |> Router.Utils.toRoute
                        |> Model.initialModel config locale
            in
                rootLocation
                    |> Main.init flags
                    |> Tuple.first
                    |> Expect.equal model


subscriptionsTest : Fuzzer Flags -> Fuzzer Navigation.Location -> Test
subscriptionsTest flags location =
    fuzz2 flags location "subscriptions" <|
        \flags location ->
            let
                config =
                    Config.init flags

                locale =
                    Locale.init flags.language

                model =
                    { location | pathname = "/" }
                        |> Router.Utils.toRoute
                        |> Model.initialModel config locale
            in
                model
                    |> Main.subscriptions
                    |> Expect.equal Sub.none
