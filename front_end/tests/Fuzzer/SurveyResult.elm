module Fuzzer.SurveyResult exposing (fuzzer, detailFuzzer)

import Fuzz exposing (Fuzzer, constant, float, int, list, maybe, string)
import Fuzzer.SurveyResultDetailId as SurveyResultDetailId
import Fuzzer.Theme as Theme
import SurveyResult.Model exposing (SurveyResult)
import Theme.Model exposing (Theme)


fuzzer : Fuzzer SurveyResult
fuzzer =
    surveyResultFuzzer (constant Nothing)


{-| NOTE: Best not to use this unless you do a low fuzz count as it
would seem that it hangs the test suite at the default fuzz count of 100.
-}
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
