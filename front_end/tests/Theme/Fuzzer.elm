module Theme.Fuzzer exposing (fuzzer)

import Fuzz exposing (Fuzzer, list, string)
import Question exposing (Question)
import Question.Fuzzer as Question
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
