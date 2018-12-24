module Header.ViewTest exposing (all)

import Expect
import Fuzz exposing (Fuzzer)
import Header
import Html.Attributes as Attributes
import Html.Styled
import Language exposing (Language)
import Language.Fuzzer as Language
import LanguageSelector
import Msg
import RemoteData
import Test exposing (Test, describe, fuzz)
import Test.Html.Query as Query
import Test.Html.Selector as Selector exposing (classes, tag)


all : Test
all =
    let
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
        webData =
            RemoteData.Loading
    in
    describe "when no data is available to display"
        [ fuzz randomLanguage "the header does not display" <|
            \language ->
                let
                    languageSelector =
                        LanguageSelector.init language

                    html =
                        Header.view
                            Msg.ChangeLanguage
                            Msg.LanguageSelector
                            language
                            languageSelector
                            webData
                in
                html
                    |> Html.Styled.toUnstyled
                    |> Query.fromHtml
                    |> Query.hasNot [ tag "header" ]
        ]


webDataPresentTest : Fuzzer Language -> Test
webDataPresentTest randomLanguage =
    let
        webData =
            RemoteData.Success ()
    in
    describe "when data is available to display"
        [ fuzz randomLanguage "the header displays" <|
            \language ->
                let
                    languageSelector =
                        LanguageSelector.init language

                    html =
                        Header.view
                            Msg.ChangeLanguage
                            Msg.LanguageSelector
                            language
                            languageSelector
                            webData
                in
                html
                    |> Html.Styled.toUnstyled
                    |> Query.fromHtml
                    |> Query.has [ tag "header" ]
        , fuzz
            randomLanguage
            "the header displays the flag of the current language"
            (\language ->
                let
                    languageSelector =
                        LanguageSelector.init language

                    html =
                        Header.view
                            Msg.ChangeLanguage
                            Msg.LanguageSelector
                            language
                            languageSelector
                            webData

                    selectedLanguageElement =
                        Selector.attribute
                            (Attributes.attribute
                                "data-name"
                                "language-selector-current-selection"
                            )

                    flagClasses =
                        String.split " " (Language.toFlagClass language)
                in
                html
                    |> Html.Styled.toUnstyled
                    |> Query.fromHtml
                    |> Query.find [ selectedLanguageElement ]
                    |> Query.children [ classes flagClasses ]
                    |> Query.count (Expect.equal 1)
            )
        ]
