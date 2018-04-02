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


{-| Initialises Model attributes

    import Config exposing (Config)
    import RemoteData exposing (RemoteData(NotRequested))
    import Routing.Route exposing (Route(ListSurveyResultsRoute))

    config : Config
    config =
        Config "http://www.example.com/survey_results"

    initialModel config ListSurveyResultsRoute
    --> Model NotRequested config ListSurveyResultsRoute

-}
initialModel : Config -> Route -> Model
initialModel config route =
    { surveyResultList = NotRequested
    , config = config
    , route = route
    }
