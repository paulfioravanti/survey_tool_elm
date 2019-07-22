module SurveyResultList.Msg exposing (Msg(..), fetched, load)

import RemoteData exposing (WebData)
import SurveyResultList.Model exposing (SurveyResultList)


type Msg
    = Load String (WebData SurveyResultList)
    | Fetched (WebData SurveyResultList)


fetched : WebData SurveyResultList -> Msg
fetched webData =
    Fetched webData


load : String -> WebData SurveyResultList -> Msg
load apiUrl surveyResultList =
    Load apiUrl surveyResultList
