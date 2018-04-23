module Router.Model exposing (Config, Context)

import Locale exposing (Language, Locale)
import Route exposing (Route)
import SurveyResult exposing (SurveyResult)
import SurveyResultList exposing (SurveyResultList)
import RemoteData exposing (WebData)


type alias Config msg =
    { updatePageMsg : () -> msg
    , localeMsg : Language -> msg
    }


type alias Context =
    { locale : Locale
    , route : Route
    , surveyResultDetail : WebData SurveyResult
    , surveyResultList : WebData SurveyResultList
    }
