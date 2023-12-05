module Update.ChangeLanguageMsgTest exposing (all)

import Expect
import Fuzz exposing (Fuzzer)
import Fuzzer.Language as Language
import Fuzzer.Route as Route
import Language exposing (Language)
import LanguageSelector exposing (LanguageSelector)
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

        randomRoute : Fuzzer Route
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
                    languageSelector : LanguageSelector
                    languageSelector =
                        LanguageSelector.init initialLanguage

                    navigation : Navigation
                    navigation =
                        Navigation.init Nothing (Just route)

                    model : Model
                    model =
                        { apiUrl = apiUrl
                        , language = initialLanguage
                        , languageSelector = languageSelector
                        , navigation = navigation
                        , surveyResultDetail = RemoteData.NotAsked
                        , surveyResultList = RemoteData.NotAsked
                        , title = Title.init (Just route) initialLanguage
                        }

                    targetLanguage : Language
                    targetLanguage =
                        languageSelector.selectableLanguages
                            |> List.head
                            |> Maybe.withDefault Language.En

                    msg : Msg
                    msg =
                        Msg.ChangeLanguage targetLanguage

                    changedLanguageModel : Model
                    changedLanguageModel =
                        Tuple.first (Update.update msg model)

                    targetLangugageIsNewLanguage : Bool
                    targetLangugageIsNewLanguage =
                        changedLanguageModel.language == targetLanguage

                    initialLanguageInSelectableLanguages : Bool
                    initialLanguageInSelectableLanguages =
                        List.member
                            initialLanguage
                            changedLanguageModel.languageSelector.selectableLanguages
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
