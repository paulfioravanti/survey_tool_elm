module MainTest exposing (mainTests)

import Expect
import Config.Fuzzer as Config
import Navigation.Location.Fuzzer as Location
import Main
import Model exposing (Model)
import Routing.Router as Router
import Test exposing (Test, describe, fuzz2)


{-| NOTE: It's not currently possible to determine whether
functions are "the same", so the Cmd Msg in the second
tuple value cannot be tested. More info at:
http://package.elm-lang.org/packages/elm-lang/core/latest/Basics#==
-}
mainTests : Test
mainTests =
    let
        config =
            Config.fuzzer

        location =
            Location.fuzzer "/"
    in
        describe "Main"
            [ fuzz2 config location "init" <|
                \config location ->
                    let
                        model =
                            location
                                |> Router.toRoute
                                |> Model.initialModel config
                    in
                        location
                            |> Main.init config
                            |> Tuple.first
                            |> Expect.equal model
            , fuzz2 config location "subscriptions" <|
                \config location ->
                    let
                        model =
                            location
                                |> Router.toRoute
                                |> Model.initialModel config
                    in
                        model
                            |> Main.subscriptions
                            |> Expect.equal Sub.none
            ]
