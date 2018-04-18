module Router exposing (route)

import Html.Styled as Html exposing (Html)
import Model exposing (Model)
import Msg exposing (Msg(RoutingMsg))
import Router.Routing as Routing


route : Model -> Html Msg.Msg
route { route, surveyResultList, surveyResultDetail } =
    Routing.route route surveyResultList surveyResultDetail
        |> Html.map RoutingMsg
