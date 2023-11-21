module Update.ChangeLanguageMsgTest exposing (all)

import Expect
import Fuzz exposing (Fuzzer)
import Language exposing (Language)
import Language.Fuzzer as Language
import LanguageSelector
import Msg
import Navigation
import RemoteData
import Route exposing (Route)
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

        randomRoute =
            Route.fuzzer
    in
    describe "Update.update with Msg.ChangeLanguage"
        [ changeLanguageTest randomApiUrl randomLanguage randomRoute
        ]


changeLanguageTest : Fuzzer String -> Fuzzer Language -> Fuzzer Route -> Test
changeLanguageTest randomApiUrl randomLanguage randomRoute =
    describe "when msg contains a target language"
        [ fuzz3
            randomApiUrl
            randomLanguage
            randomRoute
            """
            changes an initial language to a target language and moves the
            initial language into the list of selectable languages
            """
            (\apiUrl initialLanguage route ->
                let
                    languageSelector =
                        LanguageSelector.init initialLanguage

                    navigation =
                        Navigation.init Nothing (Just route)

                    model =
                        { apiUrl = apiUrl
                        , language = initialLanguage
                        , languageSelector = languageSelector
                        , navigation = navigation
                        , surveyResultDetail = RemoteData.NotAsked
                        , surveyResultList = RemoteData.NotAsked
                        , title = Title.init (Just route) initialLanguage
                        }

                    targetLanguage =
                        languageSelector.selectableLanguages
                            |> List.head
                            |> Maybe.withDefault Language.En

                    msg =
                        Msg.ChangeLanguage targetLanguage

                    changedLanguageModel =
                        Update.update msg model
                            |> Tuple.first

                    targetLangugageIsNewLanguage =
                        changedLanguageModel.language == targetLanguage

                    initialLanguageInSelectableLanguages =
                        changedLanguageModel.languageSelector.selectableLanguages
                            |> List.member initialLanguage
                in
                (targetLangugageIsNewLanguage
                    && initialLanguageInSelectableLanguages
                )
                    |> Expect.equal True
                    |> Expect.onFail
                        """
                        Expected target language to be the new model language and
                        for selectable languages to contain initial language
                        """
            )
        ]
