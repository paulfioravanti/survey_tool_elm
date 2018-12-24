module Navigation exposing (Navigation, init, updateRoute)

import Browser.Navigation exposing (Key)
import Route exposing (Route)


type alias Navigation =
    { key : Maybe Key
    , route : Maybe Route
    }


init : Maybe Key -> Maybe Route -> Navigation
init key route =
    { key = key
    , route = route
    }


updateRoute : Maybe Route -> Navigation -> Navigation
updateRoute route navigation =
    { navigation | route = route }
