module Language.Fuzzer exposing (fuzzer)

import Fuzz exposing (Fuzzer)
import Language exposing (Language)
import Random
import Shrink


fuzzer : Fuzzer Language
fuzzer =
    let
        generator : Random.Generator Language
        generator =
            Random.int 0 2
                |> Random.map
                    (\int ->
                        case int of
                            0 ->
                                Language.En

                            1 ->
                                Language.It

                            2 ->
                                Language.Ja

                            _ ->
                                Language.En
                    )

        shrinker : Shrink.Shrinker Language
        shrinker language =
            Shrink.noShrink language
    in
    Fuzz.custom generator shrinker
