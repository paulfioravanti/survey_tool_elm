module Update exposing (update)

import Browser.Navigation as Navigation
import Cmd
import Language
import LanguageSelector exposing (LanguageSelector)
import Model exposing (Model)
import Msg exposing (Msg)
import Navigation exposing (Navigation)
import Ports
import Route exposing (Route)
import SurveyResult
import SurveyResultList


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Msg.ChangeLanguage language ->
            let
                hideSelectableLanguages : Cmd Msg
                hideSelectableLanguages =
                    Cmd.hideSelectableLanguages

                maybeChangeRoute : Cmd Msg
                maybeChangeRoute =
                    Cmd.maybeChangeRoute model.navigation.route

                storeLanguage : Cmd msg
                storeLanguage =
                    Ports.storeLanguage (Language.toString language)
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
                loadDataForRoute : Cmd Msg
                loadDataForRoute =
                    Cmd.loadDataForRoute route model
            in
            ( model, loadDataForRoute )

        Msg.LanguageSelector msgForLanguageSelector ->
            let
                languageSelector : LanguageSelector
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
                maybeRoute : Maybe Route
                maybeRoute =
                    Route.init url

                navigation : Navigation
                navigation =
                    Navigation.updateRoute maybeRoute model.navigation

                maybeChangeRoute : Cmd Msg
                maybeChangeRoute =
                    Cmd.maybeChangeRoute maybeRoute
            in
            ( { model | navigation = navigation }, maybeChangeRoute )

        Msg.UrlRequested urlRequest ->
            let
                changeUrl : Cmd Msg
                changeUrl =
                    Cmd.changeUrl model.navigation.key urlRequest
            in
            ( model, changeUrl )
