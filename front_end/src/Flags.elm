module Flags exposing (Flags)

import Json.Decode


type alias Flags =
    { environment : String
    , apiUrl : Json.Decode.Value
    }
