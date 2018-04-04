module Fuzzer.SurveyResult exposing (fuzzer, detailFuzzer)

import Fuzz exposing (Fuzzer, constant, float, int, list, maybe, string)
import Fuzzer.SurveyResultDetailId as SurveyResultDetailId
import Fuzzer.Theme as Theme
import SurveyResult.Model exposing (SurveyResult)
import Theme.Model exposing (Theme)


fuzzer : Fuzzer SurveyResult
fuzzer =
    surveyResultFuzzer (constant Nothing)


detailFuzzer : Fuzzer SurveyResult
detailFuzzer =
    let
        theme =
            Theme.fuzzer
    in
        surveyResultFuzzer (maybe (list theme))


surveyResultFuzzer : Fuzzer (Maybe (List Theme)) -> Fuzzer SurveyResult
surveyResultFuzzer themeList =
    SurveyResultDetailId.fuzzer
        |> Fuzz.andThen
            (\id ->
                Fuzz.map SurveyResult string
                    |> Fuzz.andMap int
                    |> Fuzz.andMap float
                    |> Fuzz.andMap int
                    |> Fuzz.andMap themeList
                    |> Fuzz.andMap
                        (constant ("/survey_results/" ++ id ++ ".json"))
            )
