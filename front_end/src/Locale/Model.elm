module Locale.Model exposing (Locale, availableLanguages)

import I18Next exposing (Translations)
import Translations exposing (Lang(En, It, Ja))


type alias Locale =
    { language : Lang
    , showAvailableLanguages : Bool
    , translations : Translations
    }


availableLanguages : List Lang
availableLanguages =
    [ En, It, Ja ]
