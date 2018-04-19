module Update exposing (update)

import Msg
    exposing
        ( Msg
            ( SurveyResultDetailMsg
            , SurveyResultListMsg
            , RoutingMsg
            , UpdatePage
            , TranslationsLoaded
            )
        )
import Model exposing (Model)
import Page
import Router.Update
import SurveyResultDetail
import SurveyResultList


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        SurveyResultDetailMsg msg ->
            let
                ( surveyResultDetail, cmd ) =
                    SurveyResultDetail.update msg
            in
                ( { model | surveyResultDetail = surveyResultDetail }
                , Cmd.map SurveyResultDetailMsg cmd
                )

        SurveyResultListMsg msg ->
            let
                ( surveyResultList, cmd ) =
                    SurveyResultList.update msg
            in
                ( { model | surveyResultList = surveyResultList }
                , Cmd.map SurveyResultListMsg cmd
                )

        RoutingMsg msg ->
            let
                ( route, cmd ) =
                    Router.Update.update msg UpdatePage
            in
                ( { model | route = route }
                , cmd
                )

        UpdatePage _ ->
            Page.update model

        TranslationsLoaded (Ok translations) ->
            ( { model | translations = translations }, Cmd.none )

        TranslationsLoaded (Err msg) ->
            ( model, Cmd.none )
