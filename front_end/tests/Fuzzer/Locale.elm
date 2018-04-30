module Fuzzer.Locale exposing (fuzzer)

import Dict
import Fuzz exposing (Fuzzer, bool, constant, string)
import Fuzzer.Language as Language
import I18Next
import Locale.Model exposing (Locale)


fuzzer : Fuzzer Locale
fuzzer =
    let
        language =
            Language.fuzzer

        translations =
            I18Next.initialTranslations
    in
        Fuzz.map Locale language
            |> Fuzz.andMap bool
            |> Fuzz.andMap (constant translations)
