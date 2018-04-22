module SurveyResultDetail.Msg exposing (Msg(..))

import Http exposing (Error)
import SurveyResult exposing (SurveyResult)


type Msg
    = FetchSurveyResultDetail (Result Error SurveyResult)
