module Update.LanguageSelectorMsgTest exposing (all)

import Expect
import Fuzz exposing (Fuzzer)
import Language exposing (Language)
import Language.Fuzzer as Language
import LanguageSelector
import LanguageSelector.Msg
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
    in
    describe "Update.update with Msg.LanguageSelector"
        [ hideSelectableLanguagesTest randomApiUrl randomLanguage
        , toggleSelectableLanguagesTest randomApiUrl randomLanguage
        ]


hideSelectableLanguagesTest : Fuzzer String -> Fuzzer Language -> Test
hideSelectableLanguagesTest randomApiUrl randomLanguage =
    let
        randomRoute =
            Route.fuzzer
    in
    describe "when msg contains Msg.HideSelectableLanguages"
        [ fuzz3
            randomApiUrl
            randomLanguage
            randomRoute
            """
            updates the showSelectableLanguages property of the model's
            languageSelector to be False
            """
            (\apiUrl language route ->
                let
                    visibleLanguageSelector =
                        LanguageSelector.init language
                            |> (\languageSelector ->
                                    { languageSelector
                                        | showSelectableLanguages = True
                                    }
                               )

                    navigation =
                        Navigation.init Nothing (Just route)

                    model =
                        { apiUrl = apiUrl
                        , language = language
                        , languageSelector = visibleLanguageSelector
                        , navigation = navigation
                        , surveyResultDetail = RemoteData.NotAsked
                        , surveyResultList = RemoteData.NotAsked
                        , title = Title.init (Just route) language
                        }

                    msg =
                        Msg.LanguageSelector
                            LanguageSelector.Msg.HideSelectableLanguages

                    hiddenLanguageSelector =
                        Update.update msg model
                            |> Tuple.first
                            |> .languageSelector
                in
                hiddenLanguageSelector.showSelectableLanguages
                    |> Expect.equal False
                    |> Expect.onFail
                        """
                        Expected showSelectableLanguages of languageSelector
                        to be false
                        """
            )
        ]


toggleSelectableLanguagesTest : Fuzzer String -> Fuzzer Language -> Test
toggleSelectableLanguagesTest randomApiUrl randomLanguage =
    let
        route =
            Route.SurveyResultList

        navigation =
            Navigation.init Nothing (Just route)

        randomShowSelectableLanguages =
            Fuzz.bool
    in
    describe "when msg contains Msg.ToggleSelectableLanguages"
        [ fuzz3
            randomApiUrl
            randomLanguage
            randomShowSelectableLanguages
            """
            updates the showSelectableLanguages property of the model's
            languageSelector to be the opposite value
            """
            (\apiUrl language showSelectableLanguages ->
                let
                    initialLanguageSelector =
                        LanguageSelector.init language
                            |> (\languageSelector ->
                                    { languageSelector
                                        | showSelectableLanguages =
                                            showSelectableLanguages
                                    }
                               )

                    model =
                        { apiUrl = apiUrl
                        , language = language
                        , languageSelector = initialLanguageSelector
                        , navigation = navigation
                        , surveyResultDetail = RemoteData.NotAsked
                        , surveyResultList = RemoteData.NotAsked
                        , title = Title.init (Just route) language
                        }

                    msg =
                        Msg.LanguageSelector
                            LanguageSelector.Msg.ToggleSelectableLanguages

                    updatedLanguageSelector =
                        Update.update msg model
                            |> Tuple.first
                            |> .languageSelector
                in
                Expect.equal
                    updatedLanguageSelector.showSelectableLanguages
                    (not initialLanguageSelector.showSelectableLanguages)
            )
        ]
