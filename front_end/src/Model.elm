module Model exposing (Model, initialModel)

import Config exposing (Config)
import RemoteData exposing (RemoteData(NotRequested), WebData)
import Router.Route exposing (Route)
import SurveyResult exposing (SurveyResult)
import SurveyResultList exposing (SurveyResultList)


type alias Model =
    { config : Config
    , route : Route
    , surveyResultDetail : WebData SurveyResult
    , surveyResultList : WebData SurveyResultList
    }


{-| Initialises Model attributes

    import Config exposing (Config)
    import RemoteData exposing (RemoteData(NotRequested))
    import Router.Route exposing (Route(ListSurveyResultsRoute))

    config : Config
    config =
        Config "http://www.example.com/survey_results"

    initialModel config ListSurveyResultsRoute
    --> Model
    -->     config
    -->     ListSurveyResultsRoute
    -->     NotRequested
    -->     NotRequested

-}
initialModel : Config -> Route -> Model
initialModel config route =
    { config = config
    , route = route
    , surveyResultDetail = NotRequested
    , surveyResultList = NotRequested
    }
