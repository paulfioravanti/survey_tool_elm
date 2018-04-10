module Router exposing (route)

import Html.Styled as Html exposing (Html)
import Message.NotFound as NotFound
import Model exposing (Model)
import Msg exposing (Msg(RoutingMsg))
import Routing.Msg exposing (Msg(ChangeLocation))
import Routing.Route
    exposing
        ( Route
            ( ListSurveyResultsRoute
            , SurveyResultDetailRoute
            , NotFoundRoute
            )
        )
import Routing.Utils as Utils
import SurveyResult.Controller
import SurveyResultList.Controller


route : Model -> Html Msg.Msg
route { route, surveyResultList, surveyResultDetail } =
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
                    Utils.toPath ListSurveyResultsRoute
            in
                surveyResultDetail
                    |> SurveyResult.Controller.render msg path
                    |> Html.map RoutingMsg

        NotFoundRoute ->
            let
                msg =
                    (ChangeLocation ListSurveyResultsRoute)

                path =
                    Utils.toPath ListSurveyResultsRoute
            in
                NotFound.view msg path
                    |> Html.map RoutingMsg