module Routing.Msg exposing (Msg(..))

import Navigation


type Msg
    = UrlChange Navigation.Location
