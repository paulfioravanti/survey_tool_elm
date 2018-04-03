module Fuzzer.SurveyResult exposing (fuzzer)

import Fuzz exposing (Fuzzer, constant, float, int, string)
import Fuzzer.SurveyResultDetailId as SurveyResultDetailId
import SurveyResult.Model exposing (SurveyResult)


fuzzer : Fuzzer SurveyResult
fuzzer =
    SurveyResultDetailId.fuzzer
        |> Fuzz.andThen
            (\id ->
                Fuzz.map SurveyResult string
                    |> Fuzz.andMap int
                    |> Fuzz.andMap float
                    |> Fuzz.andMap int
                    |> Fuzz.andMap
                        (constant ("/survey_results/" ++ id ++ ".json"))
            )
