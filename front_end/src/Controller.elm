module Controller exposing (render)

import Html exposing (Html)
import Messages exposing (Msg)
import Model exposing (Model)
import Routing.Routes
    exposing
        ( Route
            ( ListSurveyResultsRoute
            , NotFoundRoute
            )
        )
import Shared.NotFoundMessage
import SurveyResultList.Controller


render : Model -> Html Msg
render model =
    case model.route of
        ListSurveyResultsRoute ->
            model.surveyResultList
                |> SurveyResultList.Controller.render

        NotFoundRoute ->
            Shared.NotFoundMessage.view
