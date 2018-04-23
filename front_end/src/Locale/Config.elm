module Locale.Config exposing (Config)

import Locale.Model exposing (Language)


type alias Config msg =
    { changeLanguageMsg : Language -> msg }
