module Router.Config exposing (Config)

import Locale
import Navigation exposing (Location)
import Route exposing (Route)


type alias Config msg =
    { blurMsg : Route -> msg
    , changeLanguageMsg : Locale.Msg -> msg
    , changeLocationMsg : Route -> msg
    , updatePageMsg : Location -> msg
    }
