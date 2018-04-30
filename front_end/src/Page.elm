module Page exposing (update)

{-| Updates the content of a page depending primarily on the current route.
-}

import I18Next exposing (Translations)
import Msg exposing (Msg(SurveyResultDetailMsg, SurveyResultListMsg))
import Model exposing (Model)
import RemoteData exposing (RemoteData(NotRequested, Requesting, Success))
import Route
    exposing
        ( Route
            ( ListSurveyResultsRoute
            , SurveyResultDetailRoute
            )
        )
import SurveyResult
import SurveyResultDetail
import SurveyResultList
import Window


update : Model -> ( Model, Cmd Msg )
update model =
    case model.route of
        ListSurveyResultsRoute ->
            case model.surveyResultList of
                NotRequested ->
                    ( { model | surveyResultList = Requesting }
                    , Cmd.batch
                        [ model.config.apiUrl
                            |> SurveyResultList.fetchSurveyResultList
                            |> Cmd.map SurveyResultListMsg
                        , Window.updateTitle
                            (I18Next.t model.locale.translations "loading")
                        ]
                    )

                Success _ ->
                    ( model
                    , Window.updateTitle
                        (I18Next.t model.locale.translations "surveyResults")
                    )

                _ ->
                    ( model, Cmd.none )

        SurveyResultDetailRoute id ->
            let
                fetchSurveyResultDetail =
                    ( { model | surveyResultDetail = Requesting }
                    , Cmd.batch
                        [ model.config.apiUrl
                            |> SurveyResultDetail.fetchSurveyResult id
                            |> Cmd.map SurveyResultDetailMsg
                        , Window.updateTitle
                            (I18Next.t model.locale.translations "loading")
                        ]
                    )
            in
                case model.surveyResultDetail of
                    Success surveyResultDetail ->
                        if SurveyResult.id surveyResultDetail == id then
                            ( model, Cmd.none )
                        else
                            fetchSurveyResultDetail

                    _ ->
                        fetchSurveyResultDetail

        _ ->
            ( model, Cmd.none )
