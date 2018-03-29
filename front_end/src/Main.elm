module Main exposing (main)

import Config exposing (Config)
import Model exposing (Model)
import Msg exposing (Msg(RoutingMsg, UpdatePage))
import Navigation
import Routing.Msg exposing (Msg(OnLocationChange))
import Routing.Router as Router
import Task
import Update
import View


main : Program Config Model Msg.Msg
main =
    Navigation.programWithFlags
        (RoutingMsg << OnLocationChange)
        { init = init
        , view = View.view
        , update = Update.update
        , subscriptions = \_ -> Sub.none
        }


init : Config -> Navigation.Location -> ( Model, Cmd Msg.Msg )
init config location =
    let
        model =
            location
                |> Router.toRoute
                |> Model.initialModel config
    in
        ( model
        , Task.succeed ()
            |> Task.perform UpdatePage
        )
