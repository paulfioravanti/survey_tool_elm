module Fuzzer.SurveyResultList exposing (fuzzer)

import Fuzz exposing (Fuzzer, list)
import Fuzzer.SurveyResult as SurveyResult
import SurveyResultList.Model exposing (SurveyResultList)


fuzzer : Fuzzer SurveyResultList
fuzzer =
    let
        surveyResult =
            SurveyResult.fuzzer
    in
        Fuzz.map SurveyResultList (list surveyResult)
