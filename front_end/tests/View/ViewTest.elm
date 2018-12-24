module View.ViewTest exposing (all)

import Expect
import Fuzz exposing (Fuzzer)
import Html
import Html.Attributes as Attributes
import Html.Styled
import Language exposing (Language)
import Language.Fuzzer as Language
import LanguageSelector
import Model exposing (Model)
import Navigation
import RemoteData
import Route
import Route.Fuzzer as Route
import SurveyResult.Detail.Fuzzer as SurveyResultDetail
import SurveyResultList.Fuzzer as SurveyResultList
import Test exposing (Test, describe, fuzz2, fuzz3)
import Test.Html.Query as Query
import Test.Html.Selector as Selector exposing (tag)
import Title
import View


all : Test
all =
    let
        randomApiUrl =
            Fuzz.string

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
        route =
            Just Route.SurveyResultList

        navigation =
            Navigation.init Nothing route

        surveyResultDetail =
            RemoteData.NotAsked

        randomSurveyResultList =
            SurveyResultList.fuzzer

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
                    model =
                        { apiUrl = apiUrl
                        , language = language
                        , languageSelector = LanguageSelector.init language
                        , navigation = navigation
                        , surveyResultDetail = surveyResultDetail
                        , surveyResultList = RemoteData.Success surveyResultList
                        , title = Title.init route language
                        }

                    html =
                        View.view model

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
        randomSurveyResultDetail =
            SurveyResultDetail.fuzzer

        surveyResultList =
            RemoteData.NotAsked

        route =
            Just (Route.SurveyResultDetail "1")

        navigation =
            Navigation.init Nothing route

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
        route =
            Nothing

        navigation =
            Navigation.init Nothing route

        surveyResultDetail =
            RemoteData.NotAsked

        surveyResultList =
            RemoteData.NotAsked

        notFoundMessage =
            Selector.attribute
                (Attributes.attribute "data-name" "not-found-message")
    in
    fuzz2 randomApiUrl randomLanguage "displays an error message" <|
        \apiUrl language ->
            let
                model =
                    { apiUrl = apiUrl
                    , language = language
                    , languageSelector = LanguageSelector.init language
                    , navigation = navigation
                    , surveyResultDetail = surveyResultDetail
                    , surveyResultList = surveyResultList
                    , title = Title.init route language
                    }

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
        surveyResultDetail =
            RemoteData.NotAsked

        surveyResultList =
            RemoteData.NotAsked

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
                    navigation =
                        Navigation.init Nothing route

                    model =
                        { apiUrl = apiUrl
                        , language = language
                        , languageSelector = LanguageSelector.init language
                        , navigation = navigation
                        , surveyResultDetail = surveyResultDetail
                        , surveyResultList = surveyResultList
                        , title = Title.init route language
                        }

                    html =
                        View.view model
                in
                Expect.equal html.title model.title
            )
        ]
