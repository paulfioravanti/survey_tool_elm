module Router exposing (Msg, Route, onLocationChangeMsg, route, toRoute)

import Html.Styled as Html exposing (Html)
import Navigation
import RemoteData exposing (WebData)
import Router.Msg as Msg
import Router.Route as Route
import Router.Routing as Routing
import Router.Utils as Utils
import SurveyResult exposing (SurveyResult)
import SurveyResultList exposing (SurveyResultList)


type alias Msg =
    Msg.Msg


type alias Route =
    Route.Route


onLocationChangeMsg : Navigation.Location -> Msg
onLocationChangeMsg =
    Msg.OnLocationChange


route :
    { model
        | route : Route
        , surveyResultDetail : WebData SurveyResult
        , surveyResultList : WebData SurveyResultList
    }
    -> Html Msg
route { route, surveyResultList, surveyResultDetail } =
    Routing.route route surveyResultList surveyResultDetail


toRoute : Navigation.Location -> Route
toRoute location =
    Utils.toRoute location
