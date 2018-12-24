module Update.ChangeRouteMsgTest exposing (all)

import Expect
import Fuzz exposing (Fuzzer)
import Language exposing (Language)
import Language.Fuzzer as Language
import LanguageSelector
import Msg
import Navigation
import RemoteData
import Route.Fuzzer as Route
import Test exposing (Test, describe, fuzz2, fuzz3)
import Title
import Update


all : Test
all =
    let
        randomApiUrl =
            Fuzz.string

        randomLanguage =
            Language.fuzzer
    in
    describe "Update.update with Msg.ChangeRoute"
        [ changeRouteTest randomApiUrl randomLanguage
        ]


changeRouteTest : Fuzzer String -> Fuzzer Language -> Test
changeRouteTest randomApiUrl randomLanguage =
    let
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
                    navigation =
                        Navigation.init Nothing (Just route)

                    msg =
                        Msg.ChangeRoute route

                    expectedModel =
                        { apiUrl = apiUrl
                        , language = language
                        , languageSelector = LanguageSelector.init language
                        , navigation = navigation
                        , surveyResultDetail = RemoteData.NotAsked
                        , surveyResultList = RemoteData.NotAsked
                        , title = Title.init (Just route) language
                        }

                    actualModel =
                        Update.update msg expectedModel
                            |> Tuple.first
                in
                Expect.equal expectedModel actualModel
            )
        ]
