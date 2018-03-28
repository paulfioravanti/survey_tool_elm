module Model exposing (Model, initialModel)

import Config exposing (Config)
import RemoteData exposing (RemoteData(NotRequested), WebData)
import Routing.Routes exposing (Route)
import SurveyResultList.Model exposing (SurveyResultList)


type alias Model =
    { surveyResultList : WebData SurveyResultList
    , config : Config
    , route : Route
    }


initialModel : Route -> Config -> Model
initialModel route config =
    { surveyResultList = NotRequested
    , config = config
    , route = route
    }
