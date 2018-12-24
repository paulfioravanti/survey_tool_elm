module Flags exposing (Flags)

import Json.Decode exposing (Value)


type alias Flags =
    { apiUrl : Value
    , environment : Value
    , language : Value
    }
