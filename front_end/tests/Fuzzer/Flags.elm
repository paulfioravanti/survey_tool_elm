module Fuzzer.Flags exposing (fuzzer)

import Fuzz exposing (Fuzzer, constant, string)
import Flags exposing (Flags)
import Json.Encode as Encode


fuzzer : Fuzzer Flags
fuzzer =
    Fuzz.map Flags (constant (Encode.string "production"))
        |> Fuzz.andMap (constant (Encode.string "http://www.example.com/"))
        |> Fuzz.andMap (constant (Encode.string "en"))
