module Main exposing (main)

import Html
import Messages exposing (Msg)
import Model exposing (Model)
import Update
import View


main : Program Never Model Msg
main =
    Html.program
        { init = init
        , view = View.view
        , update = Update.update
        , subscriptions = always Sub.none
        }


init : ( Model, Cmd Msg )
init =
    ( {}, Cmd.none )
