module Update.UrlRequestedMsgTest exposing (all)

import Browser exposing (UrlRequest)
import Expect
import Fuzz exposing (Fuzzer)
import Language exposing (Language)
import Language.Fuzzer as Language
import LanguageSelector
import Model exposing (Model)
import Msg exposing (Msg)
import Navigation exposing (Navigation)
import RemoteData exposing (WebData)
import Route exposing (Route)
import SurveyResult exposing (SurveyResult)
import SurveyResultList exposing (SurveyResultList)
import Test exposing (Test, describe, fuzz3)
import Title
import Update
import UrlRequest.Fuzzer as UrlRequest


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
    describe "Update.update with Msg.UrlRequested"
        [ urlRequestedTest randomApiUrl randomLanguage
        ]


urlRequestedTest : Fuzzer String -> Fuzzer Language -> Test
urlRequestedTest randomApiUrl randomLanguage =
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

        randomUrlRequest : Fuzzer UrlRequest
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
                    msg : Msg
                    msg =
                        Msg.UrlRequested urlRequest

                    expectedModel : Model
                    expectedModel =
                        { apiUrl = apiUrl
                        , language = language
                        , languageSelector = LanguageSelector.init language
                        , navigation = navigation
                        , surveyResultDetail = surveyResultDetail
                        , surveyResultList = surveyResultList
                        , title = Title.init route language
                        }

                    actualModel : Model
                    actualModel =
                        Tuple.first (Update.update msg expectedModel)
                in
                Expect.equal expectedModel actualModel
            )
        ]
