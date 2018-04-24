module Router.Config exposing (Config)

import Locale exposing (Language)
import Navigation exposing (Location)


type alias Config msg =
    { changeLanguageMsg : Language -> msg
    , updatePageMsg : Location -> msg
    }
