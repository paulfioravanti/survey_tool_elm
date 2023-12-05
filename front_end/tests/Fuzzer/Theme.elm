module Fuzzer.Theme exposing (fuzzer)

import Fuzz exposing (Fuzzer, list, string)
import Fuzzer.Question as Question
import Question exposing (Question)
import Theme.Model exposing (Theme)


fuzzer : Fuzzer Theme
fuzzer =
    let
        question : Fuzzer Question
        question =
            Question.fuzzer
    in
    Fuzz.map Theme string
        |> Fuzz.andMap (list question)
