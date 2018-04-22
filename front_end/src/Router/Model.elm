module Router.Model exposing (Config)

import Locale exposing (Locale)
import Route exposing (Route)
import SurveyResult exposing (SurveyResult)
import SurveyResultList exposing (SurveyResultList)
import RemoteData exposing (WebData)


type alias Config =
    { locale : Locale
    , route : Route
    , surveyResultDetail : WebData SurveyResult
    , surveyResultList : WebData SurveyResultList
    }
