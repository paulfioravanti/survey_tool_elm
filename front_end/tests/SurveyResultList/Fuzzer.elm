module SurveyResultList.Fuzzer exposing (fuzzer)

import Fuzz exposing (Fuzzer, list)
import SurveyResult exposing (SurveyResult)
import SurveyResult.Fuzzer as SurveyResult
import SurveyResultList.Model exposing (SurveyResultList)


fuzzer : Fuzzer SurveyResultList
fuzzer =
    let
        surveyResult : Fuzzer SurveyResult
        surveyResult =
            SurveyResult.fuzzer
    in
    Fuzz.map SurveyResultList (list surveyResult)
