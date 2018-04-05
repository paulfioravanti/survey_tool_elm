module Page.Update exposing (update)

import Msg exposing (Msg(SurveyResultListMsg))
import Model exposing (Model)
import RemoteData exposing (RemoteData(NotRequested, Requesting))
import Routing.Route
    exposing
        ( Route
            ( ListSurveyResultsRoute
            , SurveyResultDetailRoute
            )
        )
import SurveyResultList.Cmd


update : Model -> ( Model, Cmd Msg )
update model =
    case model.route of
        ListSurveyResultsRoute ->
            case model.surveyResultList of
                NotRequested ->
                    ( { model | surveyResultList = Requesting }
                    , model.config.apiUrl
                        |> SurveyResultList.Cmd.fetchSurveyResultList
                        |> Cmd.map SurveyResultListMsg
                    )

                _ ->
                    ( model, Cmd.none )

        SurveyResultDetailRoute id ->
            case model.surveyResultDetail of
                _ ->
                    ( model, Cmd.none )

        _ ->
            ( model, Cmd.none )
