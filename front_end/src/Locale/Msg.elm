module Locale.Msg exposing (Msg(..))

import Http
import I18Next exposing (Translations)


type Msg
    = TranslationsLoaded (Result Http.Error Translations)
