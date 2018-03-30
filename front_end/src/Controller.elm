module Controller exposing (render)

import Html exposing (Html)
import Messages.NotFound as NotFound
import Model exposing (Model)
import Msg exposing (Msg(RoutingMsg))
import Routing.Msg exposing (Msg(ChangeLocation))
import Routing.Router as Router
import Routing.Route
    exposing
        ( Route
            ( ListSurveyResultsRoute
            , SurveyResultDetailRoute
            , NotFoundRoute
            )
        )
import SurveyResultList.Controller


render : Model -> Html Msg.Msg
render model =
    case model.route of
        ListSurveyResultsRoute ->
            let
                msg =
                    (ChangeLocation << SurveyResultDetailRoute)
            in
                model.surveyResultList
                    |> SurveyResultList.Controller.render msg
                    |> Html.map RoutingMsg

        SurveyResultDetailRoute id ->
            let
                msg =
                    (ChangeLocation ListSurveyResultsRoute)

                path =
                    Router.toPath ListSurveyResultsRoute
            in
                NotFound.view msg path
                    |> Html.map RoutingMsg

        NotFoundRoute ->
            let
                msg =
                    (ChangeLocation ListSurveyResultsRoute)

                path =
                    Router.toPath ListSurveyResultsRoute
            in
                NotFound.view msg path
                    |> Html.map RoutingMsg
