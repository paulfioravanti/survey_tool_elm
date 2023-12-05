module View.ViewTest exposing (all)

import Browser exposing (Document)
import Expect
import Fuzz exposing (Fuzzer)
import Fuzzer.Language as Language
import Fuzzer.Route as Route
import Fuzzer.SurveyResultDetail as SurveyResultDetail
import Fuzzer.SurveyResultList as SurveyResultList
import Html exposing (Html)
import Html.Attributes as Attributes
import Language exposing (Language)
import LanguageSelector
import Model exposing (Model)
import Msg exposing (Msg)
import Navigation exposing (Navigation)
import RemoteData exposing (WebData)
import Route exposing (Route)
import SurveyResult exposing (SurveyResult)
import SurveyResultList exposing (SurveyResultList)
import Test exposing (Test, describe, fuzz2, fuzz3)
import Test.Html.Query as Query
import Test.Html.Selector as Selector exposing (Selector, tag)
import Title
import View


all : Test
all =
    let
        randomApiUrl : Fuzzer String
        randomApiUrl =
            Fuzz.string

        randomLanguage : Fuzzer Language
        randomLanguage =
            Language.fuzzer
    in
    describe "View.view"
        [ viewWhenRouteIsSurveyResultListTest randomApiUrl randomLanguage
        , viewWhenRouteIsSurveyResultDetailTest randomApiUrl randomLanguage
        , viewWhenRouteIsNotFoundTest randomApiUrl randomLanguage
        , viewTitleTest randomApiUrl randomLanguage
        ]


viewWhenRouteIsSurveyResultListTest : Fuzzer String -> Fuzzer Language -> Test
viewWhenRouteIsSurveyResultListTest randomApiUrl randomLanguage =
    let
        route : Maybe Route
        route =
            Just Route.SurveyResultList

        navigation : Navigation
        navigation =
            Navigation.init Nothing route

        surveyResultDetail : WebData SurveyResult
        surveyResultDetail =
            RemoteData.NotAsked

        randomSurveyResultList : Fuzzer SurveyResultList
        randomSurveyResultList =
            SurveyResultList.fuzzer

        surveyResults : Selector
        surveyResults =
            Selector.attribute
                (Attributes.attribute "data-name" "survey-results")
    in
    describe "when route is for the survey result list"
        [ fuzz3
            randomApiUrl
            randomLanguage
            randomSurveyResultList
            "displays a list of survey results"
            (\apiUrl language surveyResultList ->
                let
                    model : Model
                    model =
                        { apiUrl = apiUrl
                        , language = language
                        , languageSelector = LanguageSelector.init language
                        , navigation = navigation
                        , surveyResultDetail = surveyResultDetail
                        , surveyResultList = RemoteData.Success surveyResultList
                        , title = Title.init route language
                        }

                    htmlBody : Html Msg
                    htmlBody =
                        model
                            |> View.view
                            |> .body
                            |> List.reverse
                            |> List.head
                            |> Maybe.withDefault (Html.text "")
                in
                htmlBody
                    |> Query.fromHtml
                    |> Query.has [ tag "section", surveyResults ]
            )
        ]


viewWhenRouteIsSurveyResultDetailTest : Fuzzer String -> Fuzzer Language -> Test
viewWhenRouteIsSurveyResultDetailTest randomApiUrl randomLanguage =
    let
        randomSurveyResultDetail : Fuzzer SurveyResult
        randomSurveyResultDetail =
            SurveyResultDetail.fuzzer

        surveyResultList : WebData SurveyResultList
        surveyResultList =
            RemoteData.NotAsked

        route : Maybe Route
        route =
            Just (Route.SurveyResultDetail "1")

        navigation : Navigation
        navigation =
            Navigation.init Nothing route

        surveyResults : Selector
        surveyResults =
            Selector.attribute
                (Attributes.attribute "data-name" "survey-result-detail")
    in
    describe "when route is for a survey result detail"
        [ fuzz3
            randomApiUrl
            randomLanguage
            randomSurveyResultDetail
            "displays the details of a survey result"
            (\apiUrl language surveyResultDetail ->
                let
                    model : Model
                    model =
                        { apiUrl = apiUrl
                        , language = language
                        , languageSelector = LanguageSelector.init language
                        , navigation = navigation
                        , surveyResultDetail =
                            RemoteData.Success surveyResultDetail
                        , surveyResultList = surveyResultList
                        , title = Title.init route language
                        }

                    htmlBody : Html Msg
                    htmlBody =
                        model
                            |> View.view
                            |> .body
                            |> List.reverse
                            |> List.head
                            |> Maybe.withDefault (Html.text "")
                in
                htmlBody
                    |> Query.fromHtml
                    |> Query.has [ tag "article", surveyResults ]
            )
        ]


viewWhenRouteIsNotFoundTest : Fuzzer String -> Fuzzer Language -> Test
viewWhenRouteIsNotFoundTest randomApiUrl randomLanguage =
    let
        route : Maybe Route
        route =
            Nothing

        navigation : Navigation
        navigation =
            Navigation.init Nothing route

        surveyResultDetail : WebData SurveyResult
        surveyResultDetail =
            RemoteData.NotAsked

        surveyResultList : WebData SurveyResultList
        surveyResultList =
            RemoteData.NotAsked

        notFoundMessage : Selector
        notFoundMessage =
            Selector.attribute
                (Attributes.attribute "data-name" "not-found-message")
    in
    fuzz2 randomApiUrl randomLanguage "displays an error message" <|
        \apiUrl language ->
            let
                model : Model
                model =
                    { apiUrl = apiUrl
                    , language = language
                    , languageSelector = LanguageSelector.init language
                    , navigation = navigation
                    , surveyResultDetail = surveyResultDetail
                    , surveyResultList = surveyResultList
                    , title = Title.init route language
                    }

                htmlBody : Html Msg
                htmlBody =
                    model
                        |> View.view
                        |> .body
                        |> List.reverse
                        |> List.head
                        |> Maybe.withDefault (Html.text "")
            in
            htmlBody
                |> Query.fromHtml
                |> Query.has [ tag "section", notFoundMessage ]


viewTitleTest : Fuzzer String -> Fuzzer Language -> Test
viewTitleTest randomApiUrl randomLanguage =
    let
        surveyResultDetail : WebData SurveyResult
        surveyResultDetail =
            RemoteData.NotAsked

        surveyResultList : WebData SurveyResultList
        surveyResultList =
            RemoteData.NotAsked

        randomRoute : Fuzzer (Maybe Route)
        randomRoute =
            Fuzz.maybe Route.fuzzer
    in
    describe "view title"
        [ fuzz3
            randomApiUrl
            randomLanguage
            randomRoute
            "displays the title stored in the model"
            (\apiUrl language route ->
                let
                    navigation : Navigation
                    navigation =
                        Navigation.init Nothing route

                    model : Model
                    model =
                        { apiUrl = apiUrl
                        , language = language
                        , languageSelector = LanguageSelector.init language
                        , navigation = navigation
                        , surveyResultDetail = surveyResultDetail
                        , surveyResultList = surveyResultList
                        , title = Title.init route language
                        }

                    html : Document Msg
                    html =
                        View.view model
                in
                Expect.equal html.title model.title
            )
        ]
