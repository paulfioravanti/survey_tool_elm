module Router.Config exposing (Config)

import Locale
import Router.Msg as Msg


type alias Config msg =
    { blurMsg : msg
    , localeMsg : Locale.Msg -> msg
    , routingMsg : Msg.Msg -> msg
    }
