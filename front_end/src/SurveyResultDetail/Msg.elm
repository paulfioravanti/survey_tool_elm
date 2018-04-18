module SurveyResultDetail.Msg exposing (Msg(..))

import Http
import SurveyResult exposing (SurveyResult)


type Msg
    = FetchSurveyResultDetail (Result Http.Error SurveyResult)
