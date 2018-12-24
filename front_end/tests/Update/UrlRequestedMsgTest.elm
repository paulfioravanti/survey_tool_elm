module Update.UrlRequestedMsgTest exposing (all)

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
    describe "Update.update with Msg.UrlRequested"
        [ urlRequestedTest randomApiUrl randomLanguage
        ]


urlRequestedTest : Fuzzer String -> Fuzzer Language -> Test
urlRequestedTest randomApiUrl randomLanguage =
    let
        route =
            Just Route.SurveyResultList

        navigation =
            Navigation.init Nothing route

        surveyResultDetail =
            RemoteData.NotAsked

        surveyResultList =
            RemoteData.NotAsked

        randomUrlRequest =
            UrlRequest.fuzzer
    in
    describe "when msg contains a UrlRequest"
        [ fuzz3
            randomApiUrl
            randomLanguage
            randomUrlRequest
            "returns model as-is and sends a command to change the url"
            (\apiUrl language urlRequest ->
                let
                    msg =
                        Msg.UrlRequested urlRequest

                    expectedModel =
                        { apiUrl = apiUrl
                        , language = language
                        , languageSelector = LanguageSelector.init language
                        , navigation = navigation
                        , surveyResultDetail = surveyResultDetail
                        , surveyResultList = surveyResultList
                        , title = Title.init route language
                        }

                    actualModel =
                        Update.update msg expectedModel
                            |> Tuple.first
                in
                Expect.equal expectedModel actualModel
            )
        ]
