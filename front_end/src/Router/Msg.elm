module Router.Msg exposing (Msg(..))

import Navigation
import Route exposing (Route)


type Msg
    = ChangeLocation Route
    | OnLocationChange Navigation.Location
    | NoOp Route
