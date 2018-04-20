module Fuzzer.Config exposing (fuzzer)

import Fuzz exposing (Fuzzer, string, constant)
import Config exposing (Config)
import Locale exposing (Language(En))


fuzzer : Fuzzer Config
fuzzer =
    Fuzz.map Config string
        |> Fuzz.andMap (constant En)
