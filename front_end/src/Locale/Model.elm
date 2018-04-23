module Locale.Model
    exposing
        ( Config
        , Language(..)
        , Locale
        , availableLanguages
        )

import I18Next exposing (Translations)


type Language
    = En
    | It
    | Ja


type alias Config msg =
    { changeLanguageMsg : Language -> msg }


type alias Locale =
    { language : Language
    , translations : Translations
    }


availableLanguages : List Language
availableLanguages =
    [ En, It, Ja ]
