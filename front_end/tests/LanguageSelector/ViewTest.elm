module LanguageSelector.ViewTest exposing (all)

import Expect
import Fuzz exposing (Fuzzer)
import Html
import Html.Attributes as Attributes
import Html.Styled
import Language exposing (Language)
import Language.Fuzzer as Language
import LanguageSelector
import LanguageSelector.Msg
import Msg
import Test exposing (Test, describe, fuzz)
import Test.Html.Event as Event exposing (click, mouseLeave)
import Test.Html.Query as Query
import Test.Html.Selector as Selector exposing (tag)


all : Test
all =
    let
        randomLanguage =
            Language.fuzzer
    in
    describe "LanguageSelector.view"
        [ openDropdownTest randomLanguage
        , closeDropdownTest randomLanguage
        , changeLanguageTest randomLanguage
        ]


openDropdownTest : Fuzzer Language -> Test
openDropdownTest randomLanguage =
    let
        currentLanguageSelection =
            Selector.attribute
                (Attributes.attribute
                    "data-name"
                    "language-selector-current-selection"
                )
    in
    describe "clicking the language dropdown menu"
        [ fuzz
            randomLanguage
            """
            sends a message to toggle the display of the available languages
            """
            (\language ->
                let
                    languageSelector =
                        LanguageSelector.init language

                    toggleSelectableLanguagesMsg =
                        Msg.LanguageSelector
                            LanguageSelector.Msg.ToggleSelectableLanguages

                    html =
                        LanguageSelector.view
                            Msg.ChangeLanguage
                            Msg.LanguageSelector
                            language
                            languageSelector
                in
                html
                    |> Html.Styled.toUnstyled
                    |> Query.fromHtml
                    |> Query.find [ currentLanguageSelection ]
                    |> Event.simulate click
                    |> Event.expect toggleSelectableLanguagesMsg
            )
        ]


closeDropdownTest : Fuzzer Language -> Test
closeDropdownTest randomLanguage =
    describe "clicking the language dropdown menu and then abandoning"
        [ fuzz
            randomLanguage
            """
            sends a message to hide the display of the available languages
            """
            (\language ->
                let
                    visibleLanguageSelector =
                        language
                            |> LanguageSelector.init
                            |> (\languageSelector ->
                                    { languageSelector
                                        | showSelectableLanguages = True
                                    }
                               )

                    hideSelectableLanguagesMsg =
                        Msg.LanguageSelector
                            LanguageSelector.Msg.HideSelectableLanguages

                    html =
                        LanguageSelector.view
                            Msg.ChangeLanguage
                            Msg.LanguageSelector
                            language
                            visibleLanguageSelector
                in
                html
                    |> Html.Styled.toUnstyled
                    |> Query.fromHtml
                    |> Event.simulate mouseLeave
                    |> Event.expect hideSelectableLanguagesMsg
            )
        ]


changeLanguageTest : Fuzzer Language -> Test
changeLanguageTest randomLanguage =
    describe "clicking a selectable language from the dropdown menu"
        [ fuzz randomLanguage "changes the language" <|
            \language ->
                let
                    languageSelector =
                        LanguageSelector.init language

                    targetLanguage =
                        languageSelector.selectableLanguages
                            |> List.head
                            |> Maybe.withDefault Language.En

                    targetLanguageElement =
                        Selector.attribute
                            (Attributes.attribute
                                "data-name"
                                ("language-" ++ Language.toString targetLanguage)
                            )

                    changeLanguageMsg =
                        Msg.ChangeLanguage targetLanguage

                    html =
                        LanguageSelector.view
                            Msg.ChangeLanguage
                            Msg.LanguageSelector
                            language
                            languageSelector
                in
                html
                    |> Html.Styled.toUnstyled
                    |> Query.fromHtml
                    |> Query.find [ targetLanguageElement ]
                    |> Event.simulate click
                    |> Event.expect changeLanguageMsg
        ]
