module Router.Context exposing (Context)

import Locale exposing (Locale)
import Navigation exposing (Location)
import Route exposing (Route)
import SurveyResult exposing (SurveyResult)
import SurveyResultList exposing (SurveyResultList)
import RemoteData exposing (WebData)


type alias Context =
    { locale : Locale
    , location : Location
    , route : Route
    , surveyResultDetail : WebData SurveyResult
    , surveyResultList : WebData SurveyResultList
    }
