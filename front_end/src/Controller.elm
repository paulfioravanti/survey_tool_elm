module Controller exposing (render)

import Html exposing (Html)
import Messages.NotFound as NotFound
import Model exposing (Model)
import Msg exposing (Msg)
import Routes
    exposing
        ( Route
            ( ListSurveyResultsRoute
            , NotFoundRoute
            )
        )
import SurveyResultList.Controller


render : Model -> Html Msg
render model =
    case model.route of
        ListSurveyResultsRoute ->
            model.surveyResultList
                |> SurveyResultList.Controller.render

        NotFoundRoute ->
            NotFound.view
