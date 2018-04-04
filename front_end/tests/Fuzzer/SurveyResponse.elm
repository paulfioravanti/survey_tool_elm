module Fuzzer.SurveyResponse exposing (fuzzer)

import Fuzz exposing (Fuzzer, int, string)
import SurveyResponse.Model exposing (SurveyResponse)


fuzzer : Fuzzer SurveyResponse
fuzzer =
    Fuzz.map SurveyResponse int
        |> Fuzz.andMap int
        |> Fuzz.andMap int
        |> Fuzz.andMap string
