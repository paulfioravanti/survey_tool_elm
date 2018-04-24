module Router.Msg exposing (Msg(..))

import Route exposing (Route)


type Msg
    = Blur Route
    | ChangeLocation Route
