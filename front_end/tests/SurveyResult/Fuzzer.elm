module SurveyResult.Fuzzer exposing (fuzzer)

import Fuzz exposing (Fuzzer, float, int, string)
import SurveyResult.Model exposing (SurveyResult)


fuzzer : Fuzzer SurveyResult
fuzzer =
    Fuzz.map5
        SurveyResult
        string
        int
        float
        int
        string
