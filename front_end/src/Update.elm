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
            , Blur
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
        Blur ->
            ( model
            , Task.succeed Locale.closeAvailableLanguagesMsg
                |> Task.perform LocaleMsg
            )

        LocaleMsg localeMsg ->
            let
                ( locale, cmd ) =
                    model.locale
                        |> Locale.update localeMsg
            in
                ( { model | locale = locale }
                , Cmd.batch
                    [ Cmd.map LocaleMsg cmd
                    , Task.succeed model.location
                        |> Task.perform UpdatePage
                    ]
                )

        SurveyResultDetailMsg surveyResultDetailMsg ->
            let
                ( surveyResultDetail, cmd ) =
                    model.locale.language
                        |> SurveyResultDetail.update surveyResultDetailMsg
            in
                ( { model | surveyResultDetail = surveyResultDetail }
                , Cmd.map SurveyResultDetailMsg cmd
                )

        SurveyResultListMsg surveyResultMsg ->
            let
                ( surveyResultList, cmd ) =
                    model.locale.language
                        |> SurveyResultList.update surveyResultMsg
            in
                ( { model | surveyResultList = surveyResultList }
                , Cmd.map SurveyResultListMsg cmd
                )

        RoutingMsg routingMsg ->
            let
                ( route, cmd ) =
                    model.locale.language
                        |> Router.update routingMsg
            in
                ( { model | route = route }
                , cmd
                )

        -- suppressed parameter is `location`
        UpdatePage _ ->
            Page.update model
