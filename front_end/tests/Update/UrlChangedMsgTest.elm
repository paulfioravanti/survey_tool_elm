module Update.UrlChangedMsgTest exposing (all)

import Expect
import Fuzz exposing (Fuzzer)
import Language exposing (Language)
import Language.Fuzzer as Language
import LanguageSelector
import Msg
import Navigation
import RemoteData
import Route
import Test exposing (Test, describe, fuzz2, fuzz3)
import Title
import Update
import Url.Factory as Factory
import UrlRequest.Fuzzer as UrlRequest


all : Test
all =
    let
        randomApiUrl =
            Fuzz.string

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
        route =
            Just Route.SurveyResultList

        navigation =
            Navigation.init Nothing route

        surveyResultDetail =
            RemoteData.NotAsked

        surveyResultList =
            RemoteData.NotAsked

        url =
            Factory.urlWithPath "/survey_results/1"

        msg =
            Msg.UrlChanged url

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
                    model =
                        { apiUrl = apiUrl
                        , language = language
                        , languageSelector = LanguageSelector.init language
                        , navigation = navigation
                        , surveyResultDetail = surveyResultDetail
                        , surveyResultList = surveyResultList
                        , title = Title.init route language
                        }

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
        route =
            Just Route.SurveyResultList

        navigation =
            Navigation.init Nothing route

        surveyResultDetail =
            RemoteData.NotAsked

        surveyResultList =
            RemoteData.NotAsked

        url =
            Factory.urlWithPath "/invalid/"

        msg =
            Msg.UrlChanged url

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
                    model =
                        { apiUrl = apiUrl
                        , language = language
                        , languageSelector = LanguageSelector.init language
                        , navigation = navigation
                        , surveyResultDetail = surveyResultDetail
                        , surveyResultList = surveyResultList
                        , title = Title.init route language
                        }

                    actualNavigation =
                        Update.update msg model
                            |> Tuple.first
                            |> .navigation
                in
                Expect.equal expectedNavigation actualNavigation
            )
        ]
