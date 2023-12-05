module Header.ViewTest exposing (all)

import Expect
import Fuzz exposing (Fuzzer)
import Fuzzer.Language as Language
import Header
import Html.Attributes as Attributes
import Html.Styled as Html exposing (Html)
import Language exposing (Language)
import LanguageSelector exposing (LanguageSelector)
import Msg exposing (Msg)
import RemoteData exposing (RemoteData)
import Test exposing (Test, describe, fuzz)
import Test.Html.Query as Query
import Test.Html.Selector as Selector exposing (Selector, classes, tag)


all : Test
all =
    let
        randomLanguage : Fuzzer Language
        randomLanguage =
            Language.fuzzer
    in
    describe "Header.view"
        [ webDataNotPresentTest randomLanguage
        , webDataPresentTest randomLanguage
        ]


webDataNotPresentTest : Fuzzer Language -> Test
webDataNotPresentTest randomLanguage =
    let
        webData : RemoteData e a
        webData =
            RemoteData.Loading
    in
    describe "when no data is available to display"
        [ fuzz randomLanguage "the header does not display" <|
            \language ->
                let
                    languageSelector : LanguageSelector
                    languageSelector =
                        LanguageSelector.init language

                    html : Html Msg
                    html =
                        Header.view
                            Msg.ChangeLanguage
                            Msg.LanguageSelector
                            language
                            languageSelector
                            webData
                in
                html
                    |> Html.toUnstyled
                    |> Query.fromHtml
                    |> Query.hasNot [ tag "header" ]
        ]


webDataPresentTest : Fuzzer Language -> Test
webDataPresentTest randomLanguage =
    let
        webData : RemoteData e ()
        webData =
            RemoteData.Success ()
    in
    describe "when data is available to display"
        [ fuzz randomLanguage "the header displays" <|
            \language ->
                let
                    languageSelector : LanguageSelector
                    languageSelector =
                        LanguageSelector.init language

                    html : Html Msg
                    html =
                        Header.view
                            Msg.ChangeLanguage
                            Msg.LanguageSelector
                            language
                            languageSelector
                            webData
                in
                html
                    |> Html.toUnstyled
                    |> Query.fromHtml
                    |> Query.has [ tag "header" ]
        , fuzz
            randomLanguage
            "the header displays the flag of the current language"
            (\language ->
                let
                    languageSelector : LanguageSelector
                    languageSelector =
                        LanguageSelector.init language

                    html : Html Msg
                    html =
                        Header.view
                            Msg.ChangeLanguage
                            Msg.LanguageSelector
                            language
                            languageSelector
                            webData

                    selectedLanguageElement : Selector
                    selectedLanguageElement =
                        Selector.attribute
                            (Attributes.attribute
                                "data-name"
                                "language-selector-current-selection"
                            )

                    flagClasses : List String
                    flagClasses =
                        String.split " " (Language.toFlagClass language)
                in
                html
                    |> Html.toUnstyled
                    |> Query.fromHtml
                    |> Query.find [ selectedLanguageElement ]
                    |> Query.children [ classes flagClasses ]
                    |> Query.count (Expect.equal 1)
            )
        ]
