module Locale.Model exposing (Language(..), Locale)

import I18Next exposing (Translations)


type Language
    = En
    | Ja


type alias Locale =
    { language : Language
    , translations : Translations
    }
