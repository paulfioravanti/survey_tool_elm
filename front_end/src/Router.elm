module Router exposing (Msg, onLocationChangeMsg, route, toRoute)

import Html.Styled as Html exposing (Html)
import Model exposing (Model)
import Navigation
import Router.Msg as Msg
import Router.Route exposing (Route)
import Router.Routing as Routing
import Router.Utils as Utils


type alias Msg =
    Msg.Msg


onLocationChangeMsg : Navigation.Location -> Msg
onLocationChangeMsg =
    Msg.OnLocationChange


route : Model -> Html Msg
route { route, surveyResultList, surveyResultDetail } =
    Routing.route route surveyResultList surveyResultDetail


toRoute : Navigation.Location -> Route
toRoute location =
    Utils.toRoute location
