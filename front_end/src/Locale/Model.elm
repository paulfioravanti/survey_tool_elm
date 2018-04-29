module Locale.Model exposing (Language(..), Locale, availableLanguages)

import I18Next exposing (Translations)


type Language
    = En
    | It
    | Ja


type alias Locale =
    { language : Language
    , showAvailableLanguages : Bool
    , translations : Translations
    }


availableLanguages : List Language
availableLanguages =
    [ En, It, Ja ]
