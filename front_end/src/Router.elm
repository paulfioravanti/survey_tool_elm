module Router exposing (Msg, route, toRoute)

import Html.Styled as Html exposing (Html)
import Model exposing (Model)
import Msg exposing (Msg(RoutingMsg))
import Navigation
import Router.Msg exposing (Msg(..))
import Router.Route exposing (Route)
import Router.Routing as Routing
import Router.Utils as Utils


type alias Msg =
    Router.Msg.Msg


route : Model -> Html Msg.Msg
route { route, surveyResultList, surveyResultDetail } =
    Routing.route route surveyResultList surveyResultDetail
        |> Html.map RoutingMsg


toRoute : Navigation.Location -> Route
toRoute location =
    Utils.toRoute location
