module SurveyResultList.Fuzzer exposing (fuzzer)

import Fuzz exposing (Fuzzer, list)
import SurveyResultList.Model exposing (SurveyResultList)
import SurveyResult.Fuzzer


fuzzer : Fuzzer SurveyResultList
fuzzer =
    let
        surveyResult =
            SurveyResult.Fuzzer.fuzzer
    in
        Fuzz.map
            SurveyResultList
            (list surveyResult)
