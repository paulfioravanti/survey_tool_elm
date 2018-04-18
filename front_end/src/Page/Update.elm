module Page.Update exposing (update)

{-| Updates the content of a page depending primarily on the current route.
-}

import Msg exposing (Msg(SurveyResultDetailMsg, SurveyResultListMsg))
import Model exposing (Model)
import RemoteData exposing (RemoteData(NotRequested, Requesting))
import Routing.Route
    exposing
        ( Route
            ( ListSurveyResultsRoute
            , SurveyResultDetailRoute
            )
        )
import SurveyResultDetail
import SurveyResultList


update : Model -> ( Model, Cmd Msg )
update model =
    case model.route of
        ListSurveyResultsRoute ->
            case model.surveyResultList of
                NotRequested ->
                    ( { model | surveyResultList = Requesting }
                    , model.config.apiUrl
                        |> SurveyResultList.fetchSurveyResultList
                        |> Cmd.map SurveyResultListMsg
                    )

                _ ->
                    ( model, Cmd.none )

        SurveyResultDetailRoute id ->
            ( { model | surveyResultDetail = Requesting }
            , model.config.apiUrl
                |> SurveyResultDetail.fetchSurveyResult id
                |> Cmd.map SurveyResultDetailMsg
            )

        _ ->
            ( model, Cmd.none )
