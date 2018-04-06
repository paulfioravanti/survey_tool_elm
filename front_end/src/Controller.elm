module Controller exposing (render)

import Html exposing (Html)
import Message.NotFound as NotFound
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
import SurveyResult.Controller
import SurveyResultList.Controller


render : Model -> Html Msg.Msg
render { route, surveyResultList, surveyResultDetail } =
    case route of
        ListSurveyResultsRoute ->
            let
                msg =
                    (ChangeLocation << SurveyResultDetailRoute)
            in
                surveyResultList
                    |> SurveyResultList.Controller.render msg
                    |> Html.map RoutingMsg

        SurveyResultDetailRoute id ->
            let
                msg =
                    (ChangeLocation ListSurveyResultsRoute)

                path =
                    Router.toPath ListSurveyResultsRoute
            in
                surveyResultDetail
                    |> SurveyResult.Controller.render msg path
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
