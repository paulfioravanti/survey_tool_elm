module Cmd exposing
    ( changeUrl
    , hideSelectableLanguages
    , loadDataForRoute
    , maybeChangeRoute
    )

import Browser exposing (UrlRequest)
import Browser.Navigation as Navigation exposing (Key)
import LanguageSelector
import Model exposing (Model)
import Msg exposing (Msg)
import Route exposing (Route)
import SurveyResult
import SurveyResultList
import Task
import Url


changeUrl : Maybe Key -> UrlRequest -> Cmd Msg
changeUrl maybeKey urlRequest =
    case urlRequest of
        Browser.Internal url ->
            case maybeKey of
                Just key ->
                    url
                        |> Url.toString
                        |> Navigation.pushUrl key

                Nothing ->
                    Cmd.none

        Browser.External href ->
            Navigation.load href


hideSelectableLanguages : Cmd Msg
hideSelectableLanguages =
    LanguageSelector.hideSelectableLanguages
        |> Msg.LanguageSelector
        |> Task.succeed
        |> Task.perform identity


loadDataForRoute : Route -> Model -> Cmd Msg
loadDataForRoute route model =
    case route of
        Route.SurveyResultList ->
            model.surveyResultList
                |> SurveyResultList.load model.apiUrl
                |> Cmd.map Msg.SurveyResultList

        Route.SurveyResultDetail id ->
            model.surveyResultDetail
                |> SurveyResult.load model.apiUrl id
                |> Cmd.map Msg.SurveyResult


maybeChangeRoute : Maybe Route -> Cmd Msg
maybeChangeRoute maybeRoute =
    case maybeRoute of
        Just route ->
            Msg.ChangeRoute route
                |> Task.succeed
                |> Task.perform identity

        Nothing ->
            Cmd.none
