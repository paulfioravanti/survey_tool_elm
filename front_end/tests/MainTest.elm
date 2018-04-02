module MainTest exposing (mainTests)

import Expect
import Factory.Config as Config
import Factory.Navigation.Location as Location
import Main
import Model exposing (Model)
import Routing.Router as Router
import Test exposing (Test, describe, test)


{-| NOTE: It's not currently possible to determine whether
functions are "the same", so the Cmd Msg in the second
tuple value cannot be tested. More info at:
http://package.elm-lang.org/packages/elm-lang/core/latest/Basics#==
-}
mainTests : Test
mainTests =
    let
        config =
            Config.factory

        location =
            Location.factory "/"

        model =
            location
                |> Router.toRoute
                |> Model.initialModel config
    in
        describe "Main"
            [ test "init" <|
                \() ->
                    Main.init config location
                        |> Tuple.first
                        |> Expect.equal model
            , test "subscriptions" <|
                \() ->
                    model
                        |> Main.subscriptions
                        |> Expect.equal Sub.none
            ]
