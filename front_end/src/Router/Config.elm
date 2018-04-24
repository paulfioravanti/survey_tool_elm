module Router.Config exposing (Config)

import Locale exposing (Language)
import Navigation exposing (Location)
import Route exposing (Route)


type alias Config msg =
    { blurMsg : Route -> msg
    , changeLanguageMsg : Language -> msg
    , changeLocationMsg : Route -> msg
    , updatePageMsg : Location -> msg
    }
