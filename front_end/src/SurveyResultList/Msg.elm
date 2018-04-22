module SurveyResultList.Msg exposing (Msg(..))

import Http exposing (Error)
import SurveyResultList.Model exposing (SurveyResultList)


type Msg
    = FetchSurveyResultList (Result Error SurveyResultList)
