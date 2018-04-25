module Update exposing (update)

import Locale
import Msg
    exposing
        ( Msg
            ( LocaleMsg
            , SurveyResultDetailMsg
            , SurveyResultListMsg
            , RoutingMsg
            , UpdatePage
            )
        )
import Model exposing (Model)
import Page
import Router
import SurveyResultDetail
import SurveyResultList
import Task


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        LocaleMsg msg ->
            let
                ( locale, cmd ) =
                    Locale.update msg model.locale
            in
                ( { model | locale = locale }
                , Cmd.batch
                    [ Cmd.map LocaleMsg cmd
                    , Task.succeed model.location
                        |> Task.perform UpdatePage
                    ]
                )

        SurveyResultDetailMsg msg ->
            let
                ( surveyResultDetail, cmd ) =
                    SurveyResultDetail.update msg model.locale.translations
            in
                ( { model | surveyResultDetail = surveyResultDetail }
                , Cmd.map SurveyResultDetailMsg cmd
                )

        SurveyResultListMsg msg ->
            let
                ( surveyResultList, cmd ) =
                    SurveyResultList.update msg model.locale.translations
            in
                ( { model | surveyResultList = surveyResultList }
                , Cmd.map SurveyResultListMsg cmd
                )

        RoutingMsg msg ->
            let
                routerConfig =
                    { blurMsg = (RoutingMsg << Router.blurMsg)
                    , localeMsg = LocaleMsg
                    , changeLocationMsg =
                        (RoutingMsg << Router.changeLocationMsg)
                    , updatePageMsg = UpdatePage
                    }

                ( route, cmd ) =
                    Router.update msg routerConfig model.locale.translations
            in
                ( { model | route = route }
                , cmd
                )

        UpdatePage location ->
            Page.update model
