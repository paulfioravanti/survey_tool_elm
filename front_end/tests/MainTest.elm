module MainTest exposing (suite)

import Expect
import Fuzzer.Config as Config
import Fuzzer.Navigation.Location as Location
import Main
import Model exposing (Model)
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
            [ fuzz2 config location "init" <|
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
            , fuzz2 config location "subscriptions" <|
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
            ]
