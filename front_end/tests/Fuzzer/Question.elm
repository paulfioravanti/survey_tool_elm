module Fuzzer.Question exposing (fuzzer)

import Fuzz exposing (Fuzzer, list, string)
import Fuzzer.SurveyResponse as SurveyResponse
import Question.Model exposing (Question)
import SurveyResponse exposing (SurveyResponse)


fuzzer : Fuzzer Question
fuzzer =
    let
        surveyResponse : Fuzzer SurveyResponse
        surveyResponse =
            SurveyResponse.fuzzer
    in
    Fuzz.map Question string
        |> Fuzz.andMap (list surveyResponse)
        |> Fuzz.andMap string
