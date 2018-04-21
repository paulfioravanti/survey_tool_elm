module Fuzzer.Language exposing (fuzzer)

import Fuzz exposing (Fuzzer)
import Random.Pcg as Random
import Locale.Model exposing (Language(En, Ja))
import Shrink


fuzzer : Fuzzer Language
fuzzer =
    let
        generator : Random.Generator Language
        generator =
            Random.int 0 1
                |> Random.map
                    (\int ->
                        case int of
                            0 ->
                                En

                            1 ->
                                Ja

                            _ ->
                                En
                    )

        shrinker : Shrink.Shrinker Language
        shrinker language =
            Shrink.noShrink language
    in
        Fuzz.custom generator shrinker
