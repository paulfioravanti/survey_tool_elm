module Controller exposing (render)

import Html exposing (Html)
import Messages.NotFound as NotFound
import Model exposing (Model)
import Msg exposing (Msg(RoutingMsg))
import Routing.Msg exposing (Msg(NavigateTo))
import Routing.Router as Router
import Routing.Route
    exposing
        ( Route
            ( ListSurveyResultsRoute
            , NotFoundRoute
            )
        )
import SurveyResultList.Controller


render : Model -> Html Msg.Msg
render model =
    case model.route of
        ListSurveyResultsRoute ->
            model.surveyResultList
                |> SurveyResultList.Controller.render

        NotFoundRoute ->
            let
                msg =
                    (NavigateTo ListSurveyResultsRoute)

                path =
                    Router.toPath ListSurveyResultsRoute
            in
                NotFound.view msg path
                    |> Html.map RoutingMsg
