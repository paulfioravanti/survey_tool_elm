module Fuzzer.Flags exposing (fuzzer)

import Fuzz exposing (Fuzzer, string)
import Flags exposing (Flags)


fuzzer : Fuzzer Flags
fuzzer =
    Fuzz.map Flags string
        |> Fuzz.andMap string
