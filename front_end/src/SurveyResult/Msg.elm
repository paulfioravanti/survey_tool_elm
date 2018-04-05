module SurveyResult.Msg exposing (Msg(..))

import Http
import SurveyResult.Model exposing (SurveyResult)


type Msg
    = FetchSurveyResult (Result Http.Error SurveyResult)
