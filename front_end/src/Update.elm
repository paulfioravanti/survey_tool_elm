module Update exposing (update)

import Browser.Navigation as Navigation
import Cmd
import Language
import LanguageSelector
import Model exposing (Model)
import Msg exposing (Msg)
import Navigation
import Ports
import Route
import SurveyResult
import SurveyResultList


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Msg.ChangeLanguage language ->
            let
                maybeChangeRoute =
                    model.navigation.route
                        |> Cmd.maybeChangeRoute

                storeLanguage =
                    language
                        |> Language.toString
                        |> Ports.storeLanguage

                hideSelectableLanguages =
                    Cmd.hideSelectableLanguages
            in
            ( Model.changeLanguage language model
            , Cmd.batch
                [ hideSelectableLanguages
                , maybeChangeRoute
                , storeLanguage
                ]
            )

        Msg.ChangeRoute route ->
            let
                loadDataForRoute =
                    model
                        |> Cmd.loadDataForRoute route
            in
            ( model, loadDataForRoute )

        Msg.LanguageSelector msgForLanguageSelector ->
            let
                languageSelector =
                    model.languageSelector
                        |> LanguageSelector.update msgForLanguageSelector
            in
            ( { model | languageSelector = languageSelector }, Cmd.none )

        Msg.SurveyResult msgForSurveyResult ->
            let
                ( surveyResult, title, cmd ) =
                    msgForSurveyResult
                        |> SurveyResult.update model.language
            in
            ( { model | surveyResultDetail = surveyResult, title = title }
            , Cmd.map Msg.SurveyResult cmd
            )

        Msg.SurveyResultList msgForSurveyResultList ->
            let
                ( surveyResultList, title, cmd ) =
                    msgForSurveyResultList
                        |> SurveyResultList.update model.language
            in
            ( { model | surveyResultList = surveyResultList, title = title }
            , Cmd.map Msg.SurveyResultList cmd
            )

        Msg.UrlChanged url ->
            let
                maybeRoute =
                    Route.init url

                navigation =
                    model.navigation
                        |> Navigation.updateRoute maybeRoute

                maybeChangeRoute =
                    maybeRoute
                        |> Cmd.maybeChangeRoute
            in
            ( { model | navigation = navigation }, maybeChangeRoute )

        Msg.UrlRequested urlRequest ->
            let
                changeUrl =
                    urlRequest
                        |> Cmd.changeUrl model.navigation.key
            in
            ( model, changeUrl )
