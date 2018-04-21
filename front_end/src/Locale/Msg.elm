module Locale.Msg exposing (Msg(..))

import Http
import I18Next exposing (Translations)


type Msg
    = FetchTranslations (Result Http.Error Translations)
