module Router.Msg exposing (Msg(..))

import Navigation exposing (Location)
import Route exposing (Route)


type Msg
    = Blur Route
    | ChangeLocation Route
    | LocationChanged Location
