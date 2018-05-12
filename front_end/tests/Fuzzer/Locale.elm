module Fuzzer.Locale exposing (fuzzer)

import Dict
import Fuzz exposing (Fuzzer, bool, constant, string)
import Fuzzer.Lang as Lang
import Locale.Model exposing (Locale)


fuzzer : Fuzzer Locale
fuzzer =
    let
        language =
            Lang.fuzzer
    in
        Fuzz.map Locale language
            |> Fuzz.andMap bool
