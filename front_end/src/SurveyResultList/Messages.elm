module SurveyResultList.Messages exposing (Msg(..))

import Http
import SurveyResultList.Model exposing (SurveyResultList)


type Msg
    = FetchSurveyResultList (Result Http.Error SurveyResultList)
