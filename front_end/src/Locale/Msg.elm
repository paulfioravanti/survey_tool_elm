module Locale.Msg exposing (Msg(..))

import Http exposing (Error)
import I18Next exposing (Translations)
import Locale.Model exposing (Language)
import Navigation exposing (Location)


type Msg
    = ChangeLanguage Language
    | FetchTranslations (Result Error Translations)
