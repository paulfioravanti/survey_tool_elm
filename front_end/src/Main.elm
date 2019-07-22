module Main exposing (init, main)

import Browser
import Browser.Navigation as Navigation exposing (Key)
import Flags exposing (Flags)
import Model exposing (Model)
import Msg exposing (Msg)
import Ports
import Styles
import Update
import Url exposing (Url)
import View


main : Program Flags Model Msg
main =
    Browser.application
        { init = init
        , update = Update.update
        , view = View.view
        , subscriptions = always Sub.none
        , onUrlRequest = Msg.urlRequested
        , onUrlChange = Msg.urlChanged
        }


init : Flags -> Url -> Key -> ( Model, Cmd Msg )
init flags url key =
    ( Model.init flags url (Just key)
    , Cmd.batch
        [ Ports.initBodyProperties Styles.body
        , Navigation.pushUrl key (Url.toString url)
        ]
    )
