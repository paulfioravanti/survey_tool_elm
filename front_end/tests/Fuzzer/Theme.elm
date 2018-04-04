module Fuzzer.Theme exposing (fuzzer)

import Fuzz exposing (Fuzzer, list, string)
import Fuzzer.Question as Question
import Theme.Model exposing (Theme)


fuzzer : Fuzzer Theme
fuzzer =
    let
        question =
            Question.fuzzer
    in
        Fuzz.map Theme string
            |> Fuzz.andMap (list question)
