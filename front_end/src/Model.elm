module Model exposing (Model, initialModel)

import Config exposing (Config)
import Locale exposing (Locale)
import RemoteData exposing (RemoteData(NotRequested), WebData)
import Router exposing (Route)
import SurveyResult exposing (SurveyResult)
import SurveyResultList exposing (SurveyResultList)


type alias Model =
    { config : Config
    , locale : Locale
    , route : Route
    , surveyResultDetail : WebData SurveyResult
    , surveyResultList : WebData SurveyResultList
    }


{-| Initialises Model attributes

    import Config exposing (Config)
    import Json.Encode as Encode
    import Locale exposing (Locale)
    import RemoteData exposing (RemoteData(NotRequested))
    import Route exposing (Route(ListSurveyResultsRoute))

    config : Config
    config =
        Config "http://www.example.com/survey_results"

    locale : Locale
    locale =
        Locale.init (Encode.string "en")

    initialModel config locale ListSurveyResultsRoute
    --> Model
    -->     config
    -->     locale
    -->     ListSurveyResultsRoute
    -->     NotRequested
    -->     NotRequested

-}
initialModel : Config -> Locale -> Route -> Model
initialModel config locale route =
    { config = config
    , locale = locale
    , route = route
    , surveyResultDetail = NotRequested
    , surveyResultList = NotRequested
    }
