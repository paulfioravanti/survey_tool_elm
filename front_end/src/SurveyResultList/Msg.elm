module SurveyResultList.Msg exposing (Msg(..))

import RemoteData exposing (WebData)
import SurveyResultList.Model exposing (SurveyResultList)


type Msg
    = Load String (WebData SurveyResultList)
    | Fetched (WebData SurveyResultList)
