module Flags exposing (Flags)

import Json.Decode exposing (Value)


type alias Flags =
    { environment : Value
    , apiUrl : Value
    , language : Value
    }
