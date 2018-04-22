module Router.Model exposing (Context)

import Locale exposing (Locale)
import Route exposing (Route)
import SurveyResult exposing (SurveyResult)
import SurveyResultList exposing (SurveyResultList)
import RemoteData exposing (WebData)


type alias Context =
    { locale : Locale
    , route : Route
    , surveyResultDetail : WebData SurveyResult
    , surveyResultList : WebData SurveyResultList
    }
