module Model exposing (Model, initialModel)

import Config exposing (Config)
import RemoteData exposing (RemoteData(NotRequested), WebData)
import Routing.Route exposing (Route)
import SurveyResultList.Model exposing (SurveyResultList)


type alias Model =
    { surveyResultList : WebData SurveyResultList
    , config : Config
    , route : Route
    }


initialModel : Config -> Route -> Model
initialModel config route =
    { surveyResultList = NotRequested
    , config = config
    , route = route
    }
