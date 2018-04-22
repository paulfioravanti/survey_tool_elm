module Locale.Msg exposing (Msg(..))

import Http
import I18Next exposing (Translations)
import Locale.Model exposing (Language)


type Msg
    = ChangeLanguage Language
    | FetchTranslations (Result Http.Error Translations)
