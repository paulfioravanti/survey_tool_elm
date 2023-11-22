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
                    Cmd.maybeChangeRoute model.navigation.route

                storeLanguage =
                    Ports.storeLanguage (Language.toString language)

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
                    Cmd.loadDataForRoute route model
            in
            ( model, loadDataForRoute )

        Msg.LanguageSelector msgForLanguageSelector ->
            let
                languageSelector =
                    LanguageSelector.update
                        msgForLanguageSelector
                        model.languageSelector
            in
            ( { model | languageSelector = languageSelector }, Cmd.none )

        Msg.SurveyResult msgForSurveyResult ->
            let
                ( surveyResult, title, cmd ) =
                    SurveyResult.update model.language msgForSurveyResult
            in
            ( { model | surveyResultDetail = surveyResult, title = title }
            , Cmd.map Msg.SurveyResult cmd
            )

        Msg.SurveyResultList msgForSurveyResultList ->
            let
                ( surveyResultList, title, cmd ) =
                    SurveyResultList.update
                        model.language
                        msgForSurveyResultList
            in
            ( { model | surveyResultList = surveyResultList, title = title }
            , Cmd.map Msg.SurveyResultList cmd
            )

        Msg.UrlChanged url ->
            let
                maybeRoute =
                    Route.init url

                navigation =
                    Navigation.updateRoute maybeRoute model.navigation

                maybeChangeRoute =
                    Cmd.maybeChangeRoute maybeRoute
            in
            ( { model | navigation = navigation }, maybeChangeRoute )

        Msg.UrlRequested urlRequest ->
            let
                changeUrl =
                    Cmd.changeUrl model.navigation.key urlRequest
            in
            ( model, changeUrl )
