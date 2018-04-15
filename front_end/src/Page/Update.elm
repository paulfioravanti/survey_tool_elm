module Page.Update exposing (update)

{-| Updates the content of a page depending primarily on the current route.
-}

import Msg exposing (Msg(SurveyResultMsg, SurveyResultListMsg))
import Model exposing (Model)
import RemoteData exposing (RemoteData(NotRequested, Requesting))
import Routing.Route
    exposing
        ( Route
            ( ListSurveyResultsRoute
            , SurveyResultDetailRoute
            )
        )
import SurveyResult.Cmd
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
            ( { model | surveyResultDetail = Requesting }
            , model.config.apiUrl
                |> SurveyResult.Cmd.fetchSurveyResult id
                |> Cmd.map SurveyResultMsg
            )

        _ ->
            ( model, Cmd.none )
