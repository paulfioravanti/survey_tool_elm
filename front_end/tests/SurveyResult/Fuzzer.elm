module SurveyResult.Fuzzer exposing (fuzzer)

import Fuzz exposing (Fuzzer, constant, float, int, list, string)
import SurveyResult.Model exposing (SurveyResult)
import Theme.Fuzzer as Theme
import Theme.Model exposing (Theme)


fuzzer : Fuzzer SurveyResult
fuzzer =
    Fuzz.map SurveyResult string
        |> Fuzz.andMap int
        |> Fuzz.andMap float
        |> Fuzz.andMap int
        |> Fuzz.andMap (constant Nothing)
        |> Fuzz.andMap string
