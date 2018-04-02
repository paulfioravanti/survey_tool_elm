module MainTest exposing (mainTests)

import Expect
import Config.Fuzzer as Config
import Factory.Navigation.Location as Location
import Main
import Model exposing (Model)
import Routing.Router as Router
import Test exposing (Test, describe, fuzz, test)


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
            Location.factory "/"
    in
        describe "Main"
            [ fuzz config "init" <|
                \config ->
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
            , fuzz config "subscriptions" <|
                \config ->
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
