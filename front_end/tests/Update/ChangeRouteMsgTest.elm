module Update.ChangeRouteMsgTest exposing (all)

import Expect
import Fuzz exposing (Fuzzer)
import Fuzzer.Language as Language
import Fuzzer.Route as Route
import Language exposing (Language)
import LanguageSelector
import Model exposing (Model)
import Msg exposing (Msg)
import Navigation exposing (Navigation)
import RemoteData
import Route exposing (Route)
import Test exposing (Test, describe, fuzz3)
import Title
import Update


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
    describe "Update.update with Msg.ChangeRoute"
        [ changeRouteTest randomApiUrl randomLanguage
        ]


changeRouteTest : Fuzzer String -> Fuzzer Language -> Test
changeRouteTest randomApiUrl randomLanguage =
    let
        randomRoute : Fuzzer Route
        randomRoute =
            Route.fuzzer
    in
    describe "when msg contains a UrlRequest"
        [ fuzz3
            randomApiUrl
            randomLanguage
            randomRoute
            "returns model as-is and sends a command to change the route"
            (\apiUrl language route ->
                let
                    navigation : Navigation
                    navigation =
                        Navigation.init Nothing (Just route)

                    msg : Msg
                    msg =
                        Msg.ChangeRoute route

                    expectedModel : Model
                    expectedModel =
                        { apiUrl = apiUrl
                        , language = language
                        , languageSelector = LanguageSelector.init language
                        , navigation = navigation
                        , surveyResultDetail = RemoteData.NotAsked
                        , surveyResultList = RemoteData.NotAsked
                        , title = Title.init (Just route) language
                        }

                    actualModel : Model
                    actualModel =
                        Tuple.first (Update.update msg expectedModel)
                in
                Expect.equal expectedModel actualModel
            )
        ]
