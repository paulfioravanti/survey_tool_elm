module Update.UrlChangedMsgTest exposing (all)

import Expect
import Factory.Url as Factory
import Fuzz exposing (Fuzzer)
import Fuzzer.Language as Language
import Language exposing (Language)
import LanguageSelector
import Model exposing (Model)
import Msg exposing (Msg)
import Navigation exposing (Navigation)
import RemoteData exposing (WebData)
import Route exposing (Route)
import SurveyResult exposing (SurveyResult)
import SurveyResultList exposing (SurveyResultList)
import Test exposing (Test, describe, fuzz2)
import Title
import Update
import Url exposing (Url)


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
    describe "Update.update with Msg.UrlChanged"
        [ urlChangedWhenValidUrlTest randomApiUrl randomLanguage
        , urlChangedWhenInvalidUrlTest randomApiUrl randomLanguage
        ]


urlChangedWhenValidUrlTest : Fuzzer String -> Fuzzer Language -> Test
urlChangedWhenValidUrlTest randomApiUrl randomLanguage =
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

        surveyResultList : WebData SurveyResultList
        surveyResultList =
            RemoteData.NotAsked

        url : Url
        url =
            Factory.urlWithPath "/survey_results/1"

        msg : Msg
        msg =
            Msg.UrlChanged url

        expectedNavigation : Navigation
        expectedNavigation =
            Navigation.init Nothing (Just (Route.SurveyResultDetail "1"))
    in
    describe "when msg contains a valid url"
        [ fuzz2
            randomApiUrl
            randomLanguage
            """
            updates the model navigation and sends a command to maybe
            change the route
            """
            (\apiUrl language ->
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

                    actualNavigation : Navigation
                    actualNavigation =
                        Update.update msg model
                            |> Tuple.first
                            |> .navigation
                in
                Expect.equal expectedNavigation actualNavigation
            )
        ]


urlChangedWhenInvalidUrlTest : Fuzzer String -> Fuzzer Language -> Test
urlChangedWhenInvalidUrlTest randomApiUrl randomLanguage =
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

        surveyResultList : WebData SurveyResultList
        surveyResultList =
            RemoteData.NotAsked

        url : Url
        url =
            Factory.urlWithPath "/invalid/"

        msg : Msg
        msg =
            Msg.UrlChanged url

        expectedNavigation : Navigation
        expectedNavigation =
            Navigation.init Nothing Nothing
    in
    describe "when msg contains an invalid url"
        [ fuzz2
            randomApiUrl
            randomLanguage
            """
            updates the model navigation with Nothing and sends a
            command to maybe change the route
            """
            (\apiUrl language ->
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

                    actualNavigation : Navigation
                    actualNavigation =
                        Update.update msg model
                            |> Tuple.first
                            |> .navigation
                in
                Expect.equal expectedNavigation actualNavigation
            )
        ]
