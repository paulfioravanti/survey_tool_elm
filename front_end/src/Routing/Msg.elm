module Routing.Msg exposing (Msg(..))

import Navigation
import Routing.Route exposing (Route)


type Msg
    = UrlChange Navigation.Location
    | NavigateTo Route
