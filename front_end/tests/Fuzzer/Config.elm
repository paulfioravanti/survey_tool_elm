module Fuzzer.Config exposing (fuzzer)

import Fuzz exposing (Fuzzer, string, constant)
import Config exposing (Config)


fuzzer : Fuzzer Config
fuzzer =
    Fuzz.map Config string
