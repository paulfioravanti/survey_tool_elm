module Fuzzer.Lang exposing (fuzzer)

import Fuzz exposing (Fuzzer)
import Random.Pcg as Random
import Translations exposing (Lang(En, Ja))
import Shrink


fuzzer : Fuzzer Lang
fuzzer =
    let
        generator : Random.Generator Lang
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

        shrinker : Shrink.Shrinker Lang
        shrinker language =
            Shrink.noShrink language
    in
        Fuzz.custom generator shrinker
