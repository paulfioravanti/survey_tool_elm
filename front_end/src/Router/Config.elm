module Router.Config exposing (Config)

import Locale exposing (Language)


type alias Config msg =
    { updatePageMsg : () -> msg
    , changeLanguageMsg : Language -> msg
    }
