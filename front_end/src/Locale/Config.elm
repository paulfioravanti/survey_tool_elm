module Locale.Config exposing (Config)

import Locale.Msg as Msg


type alias Config msg =
    { changeLanguageMsg : Msg.Msg -> msg }
