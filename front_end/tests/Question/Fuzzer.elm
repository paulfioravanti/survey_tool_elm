module Question.Fuzzer exposing (fuzzer)

import Fuzz exposing (Fuzzer, list, string)
import Question.Model exposing (Question)
import SurveyResponse.Fuzzer as SurveyResponse


fuzzer : Fuzzer Question
fuzzer =
    let
        surveyResponse =
            SurveyResponse.fuzzer
    in
    Fuzz.map Question string
        |> Fuzz.andMap (list surveyResponse)
        |> Fuzz.andMap string
