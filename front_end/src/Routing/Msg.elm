module Routing.Msg exposing (Msg(..))

import Navigation
import Routing.Route exposing (Route)


type Msg
    = ChangeLocation Route
    | OnLocationChange Navigation.Location
    | NoOp Route
