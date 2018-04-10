module Main exposing (main, init, subscriptions)

{-| NOTE: The init function does not really need to be exposed for the app
to function, but this was the only way I could think of test it. I was
unable to figure out a way to test init through main.
-}

import Config exposing (Config)
import Controller
import Html.Styled as Html
import Model exposing (Model)
import Msg exposing (Msg(RoutingMsg, UpdatePage))
import Navigation
import Routing.Msg exposing (Msg(OnLocationChange))
import Routing.Utils
import Task
import Update


main : Program Config Model Msg.Msg
main =
    Navigation.programWithFlags
        (RoutingMsg << OnLocationChange)
        { init = init
        , view = Controller.render >> Html.toUnstyled
        , update = Update.update
        , subscriptions = subscriptions
        }


init : Config -> Navigation.Location -> ( Model, Cmd Msg.Msg )
init config location =
    let
        model =
            location
                |> Routing.Utils.toRoute
                |> Model.initialModel config
    in
        ( model
        , Task.succeed ()
            |> Task.perform UpdatePage
        )


subscriptions : Model -> Sub Msg.Msg
subscriptions model =
    Sub.none
