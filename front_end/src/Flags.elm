module Flags exposing (Flags)

import Json.Decode


type alias Flags =
    { environment : Json.Decode.Value
    , apiUrl : Json.Decode.Value
    , language : Json.Decode.Value
    }
