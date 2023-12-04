module SurveyResult.Fuzzer exposing (fuzzer)

import Fuzz exposing (Fuzzer, constant, float, int, string)
import SurveyResult.Model exposing (SurveyResult)


fuzzer : Fuzzer SurveyResult
fuzzer =
    Fuzz.map SurveyResult string
        |> Fuzz.andMap int
        |> Fuzz.andMap float
        |> Fuzz.andMap int
        |> Fuzz.andMap (constant Nothing)
        |> Fuzz.andMap string
