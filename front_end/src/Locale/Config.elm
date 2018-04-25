module Locale.Config exposing (Config)

import Locale.Msg as Msg
import Navigation exposing (Location)


type alias Config msg =
    { localeMsg : Msg.Msg -> msg
    , updatePageMsg : Location -> msg
    }
