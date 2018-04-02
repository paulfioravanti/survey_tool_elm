module Fuzzer.SurveyResultDetailId exposing (fuzzer)

import Fuzz exposing (Fuzzer, conditional, string)
import Regex


fuzzer : Fuzzer String
fuzzer =
    let
        condition =
            \string ->
                string
                    |> Regex.contains (Regex.regex "[/.]")
                    |> not
    in
        string
            |> conditional
                { retries = 100
                , fallback = (\string -> "")
                , condition = condition
                }
