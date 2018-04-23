module Router.Config exposing (Config)

import Locale exposing (Language)
import Navigation exposing (Location)


type alias Config msg =
    { updatePageMsg : Location -> msg
    , changeLanguageMsg : Language -> msg
    }
