module Main exposing (main)

import Config exposing (Config)
import Messages exposing (Msg(UrlChange))
import Model exposing (Model)
import Navigation
import Router
import Update
import View


main : Program Config Model Msg
main =
    Navigation.programWithFlags
        UrlChange
        { init = init
        , view = View.view
        , update = Update.update
        , subscriptions = \_ -> Sub.none
        }


init : Config -> Navigation.Location -> ( Model, Cmd Msg )
init config location =
    location
        |> Router.toRoute
        |> Model.initialModel config
        |> Update.updateUrlChange
