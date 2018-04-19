module Model exposing (Model, initialModel)

import Config exposing (Config)
import I18Next exposing (Translations)
import RemoteData exposing (RemoteData(NotRequested), WebData)
import Router exposing (Route)
import SurveyResult exposing (SurveyResult)
import SurveyResultList exposing (SurveyResultList)


type alias Model =
    { config : Config
    , route : Route
    , surveyResultDetail : WebData SurveyResult
    , surveyResultList : WebData SurveyResultList
    , translations : Translations
    }


{-| Initialises Model attributes

    import Config exposing (Config)
    import Dict exposing (Dict)
    import I18Next exposing (Translations)
    import RemoteData exposing (RemoteData(NotRequested))
    import Route exposing (Route(ListSurveyResultsRoute))

    config : Config
    config =
        Config "http://www.example.com/survey_results"

    translations : Translations
    translations =
        I18Next.initialTranslations

    initialModel config ListSurveyResultsRoute
    --> Model
    -->     config
    -->     ListSurveyResultsRoute
    -->     NotRequested
    -->     NotRequested
    -->     translations

-}
initialModel : Config -> Route -> Model
initialModel config route =
    { config = config
    , route = route
    , surveyResultDetail = NotRequested
    , surveyResultList = NotRequested
    , translations = I18Next.initialTranslations
    }
