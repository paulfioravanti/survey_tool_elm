module LanguageSelector.ViewTest exposing (all)

import Fuzz exposing (Fuzzer)
import Html.Attributes as Attributes
import Html.Styled as Html exposing (Html)
import Language exposing (Language)
import Language.Fuzzer as Language
import LanguageSelector exposing (LanguageSelector)
import LanguageSelector.Msg
import Msg exposing (Msg)
import Test exposing (Test, describe, fuzz)
import Test.Html.Event as Event exposing (click, mouseLeave)
import Test.Html.Query as Query
import Test.Html.Selector as Selector exposing (Selector)


all : Test
all =
    let
        randomLanguage : Fuzzer Language
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
        currentLanguageSelection : Selector
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
                    languageSelector : LanguageSelector
                    languageSelector =
                        LanguageSelector.init language

                    toggleSelectableLanguagesMsg : Msg
                    toggleSelectableLanguagesMsg =
                        Msg.LanguageSelector
                            LanguageSelector.Msg.ToggleSelectableLanguages

                    html : Html Msg
                    html =
                        LanguageSelector.view
                            Msg.ChangeLanguage
                            Msg.LanguageSelector
                            language
                            languageSelector
                in
                html
                    |> Html.toUnstyled
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
                    visibleLanguageSelector : LanguageSelector
                    visibleLanguageSelector =
                        language
                            |> LanguageSelector.init
                            |> (\languageSelector ->
                                    { languageSelector
                                        | showSelectableLanguages = True
                                    }
                               )

                    hideSelectableLanguagesMsg : Msg
                    hideSelectableLanguagesMsg =
                        Msg.LanguageSelector
                            LanguageSelector.Msg.HideSelectableLanguages

                    html : Html Msg
                    html =
                        LanguageSelector.view
                            Msg.ChangeLanguage
                            Msg.LanguageSelector
                            language
                            visibleLanguageSelector
                in
                html
                    |> Html.toUnstyled
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
                    languageSelector : LanguageSelector
                    languageSelector =
                        LanguageSelector.init language

                    targetLanguage : Language
                    targetLanguage =
                        languageSelector.selectableLanguages
                            |> List.head
                            |> Maybe.withDefault Language.En

                    targetLanguageElement : Selector
                    targetLanguageElement =
                        Selector.attribute
                            (Attributes.attribute
                                "data-name"
                                ("language-" ++ Language.toString targetLanguage)
                            )

                    changeLanguageMsg : Msg
                    changeLanguageMsg =
                        Msg.ChangeLanguage targetLanguage

                    html : Html Msg
                    html =
                        LanguageSelector.view
                            Msg.ChangeLanguage
                            Msg.LanguageSelector
                            language
                            languageSelector
                in
                html
                    |> Html.toUnstyled
                    |> Query.fromHtml
                    |> Query.find [ targetLanguageElement ]
                    |> Event.simulate click
                    |> Event.expect changeLanguageMsg
        ]
