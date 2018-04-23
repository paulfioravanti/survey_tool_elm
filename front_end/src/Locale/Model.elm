module Locale.Model exposing (Language(..), Locale)

import I18Next exposing (Translations)


type Language
    = En
    | It
    | Ja


type alias Locale =
    { language : Language
    , translations : Translations
    }
