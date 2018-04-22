module Router.Msg exposing (Msg(..))

import Navigation exposing (Location)
import Route exposing (Route)


type Msg
    = ChangeLocation Route
    | OnLocationChange Location
    | Blur Route
