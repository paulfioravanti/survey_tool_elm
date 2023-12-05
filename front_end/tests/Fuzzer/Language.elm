module Fuzzer.Language exposing (fuzzer)

import Fuzz exposing (Fuzzer)
import Language exposing (Language)


fuzzer : Fuzzer Language
fuzzer =
    Fuzz.map
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
        (Fuzz.intRange 0 2)
