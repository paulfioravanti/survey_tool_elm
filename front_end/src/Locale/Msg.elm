module Locale.Msg exposing (Msg(..))

import Http exposing (Error)
import I18Next exposing (Translations)
import Locale.Model exposing (Language)


type Msg
    = ChangeLanguage Language
    | FetchTranslations (Result Error Translations)
    | ToggleAvailableLanguages
