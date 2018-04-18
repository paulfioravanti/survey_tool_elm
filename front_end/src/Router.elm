module Router exposing (route)

import Html.Styled as Html exposing (Html)
import Message.NotFound as NotFound
import Model exposing (Model)
import Msg exposing (Msg(RoutingMsg))
import Routing.Msg exposing (Msg(ChangeLocation, NoOp))
import Routing.Route
    exposing
        ( Route
            ( ListSurveyResultsRoute
            , SurveyResultDetailRoute
            , NotFoundRoute
            )
        )
import Routing.Utils as Utils
import SurveyResultDetail
import SurveyResultList


route : Model -> Html Msg.Msg
route { route, surveyResultList, surveyResultDetail } =
    case route of
        ListSurveyResultsRoute ->
            let
                msg =
                    (ChangeLocation << SurveyResultDetailRoute)
            in
                surveyResultList
                    |> SurveyResultList.view msg
                    |> Html.map RoutingMsg

        SurveyResultDetailRoute id ->
            let
                msg =
                    (ChangeLocation ListSurveyResultsRoute)

                noOpMsg =
                    (NoOp (SurveyResultDetailRoute id))

                path =
                    Utils.toPath ListSurveyResultsRoute
            in
                surveyResultDetail
                    |> SurveyResultDetail.view msg noOpMsg path
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
