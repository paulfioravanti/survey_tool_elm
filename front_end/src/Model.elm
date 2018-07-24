module Model exposing (Model, init)

import Config exposing (Config)
import Locale exposing (Locale)
import Navigation exposing (Location)
import RemoteData exposing (RemoteData(NotRequested), WebData)
import Route exposing (Route)
import Router
import SurveyResult exposing (SurveyResult)
import SurveyResultList exposing (SurveyResultList)


type alias Model =
    { config : Config
    , locale : Locale
    , location : Location
    , route : Route
    , surveyResultDetail : WebData SurveyResult
    , surveyResultList : WebData SurveyResultList
    }


{-| Initialises Model attributes

    import Config exposing (Config)
    import Json.Encode as Encode
    import Locale exposing (Locale)
    import Navigation exposing (Location)
    import RemoteData exposing (RemoteData(NotRequested))
    import Route exposing (Route(ListSurveyResults))

    config : Config
    config =
        Config "http://www.example.com/survey_results"

    locale : Locale
    locale =
        Locale.init (Encode.string "en")

    location : Location
    location =
        Location "/survey_results" "" "" "" "" "" "" "" "" "" ""


    init config locale location
    --> Model
    -->     config
    -->     locale
    -->     location
    -->     ListSurveyResults
    -->     NotRequested
    -->     NotRequested

-}
init : Config -> Locale -> Location -> Model
init config locale location =
    let
        route =
            Router.toRoute location
    in
        { config = config
        , locale = locale
        , location = location
        , route = route
        , surveyResultDetail = NotRequested
        , surveyResultList = NotRequested
        }
