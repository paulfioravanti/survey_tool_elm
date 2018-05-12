module Locale.Model exposing (Locale, availableLanguages)

import Translations exposing (Lang(En, It, Ja))


type alias Locale =
    { language : Lang
    , showAvailableLanguages : Bool
    }


availableLanguages : List Lang
availableLanguages =
    [ En, It, Ja ]
