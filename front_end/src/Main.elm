module Main exposing (main, init, subscriptions)

{-| NOTE: The init function does not really need to be exposed for the app
to function, but this was the only way I could think of test it. I was
unable to figure out a way to test init through main.
-}

import Config exposing (Config)
import Flags exposing (Flags)
import Html.Styled as Html exposing (Html)
import Model exposing (Model)
import Msg exposing (Msg(RoutingMsg, UpdatePage))
import Navigation
import Router
import Router.Msg
import Task
import Update


main : Program Flags Model Msg.Msg
main =
    Navigation.programWithFlags
        (RoutingMsg << Router.Msg.OnLocationChange)
        { init = init
        , view = Router.route >> Html.toUnstyled
        , update = Update.update
        , subscriptions = subscriptions
        }


init : Flags -> Navigation.Location -> ( Model, Cmd Msg.Msg )
init flags location =
    let
        config =
            Config.init flags

        model =
            location
                |> Router.toRoute
                |> Model.initialModel config
    in
        ( model
        , Task.succeed ()
            |> Task.perform UpdatePage
        )


subscriptions : Model -> Sub Msg.Msg
subscriptions model =
    Sub.none
