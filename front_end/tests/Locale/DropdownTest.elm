module Locale.DropdownTest exposing (suite)

import Config exposing (Config)
import Expect
import Fuzz exposing (Fuzzer)
import Fuzzer.Config as Config
import Fuzzer.Lang as Lang
import Fuzzer.Navigation.Location as Location
import Fuzzer.SurveyResultList as SurveyResultList
import Html.Attributes as Attributes
import Html.Styled
import Locale.Model exposing (Locale)
import Locale.Msg exposing (Msg(ChangeLanguage, ToggleAvailableLanguages))
import Main
import Model exposing (Model)
import Msg exposing (Msg(LocaleMsg))
import Navigation exposing (Location)
import RemoteData exposing (RemoteData(NotRequested, Success))
import Route exposing (Route(ListSurveyResultsRoute))
import SurveyResultList exposing (SurveyResultList)
import Test exposing (Test, describe, fuzz3, fuzz4)
import Test.Html.Event as Event exposing (click)
import Test.Html.Query as Query
import Test.Html.Selector as Selector exposing (attribute, class, tag)
import Translations exposing (Lang(En, It, Ja))


suite : Test
suite =
    let
        config =
            Config.fuzzer

        location =
            Location.fuzzer

        surveyResultList =
            SurveyResultList.fuzzer
    in
        describe "language dropdown menu"
            [ currentLanguageFlagDisplayTests config location surveyResultList
            , openDropdownTest config location surveyResultList
            , changeLanguageTest config location surveyResultList
            ]


currentLanguageFlagDisplayTests :
    Fuzzer Config
    -> Fuzzer Location
    -> Fuzzer SurveyResultList
    -> Test
currentLanguageFlagDisplayTests config location surveyResultList =
    let
        dropdownCurrentSelection =
            Selector.attribute
                (Attributes.attribute
                    "data-name"
                    "locale-dropdown-current-selection"
                )
    in
        describe "flag representations for language"
            [ fuzz3
                config
                location
                surveyResultList
                "shows the Australian flag for the English language"
                (\config location surveyResultList ->
                    let
                        locale =
                            (Locale En False)

                        model =
                            Model
                                config
                                locale
                                location
                                ListSurveyResultsRoute
                                NotRequested
                                (Success surveyResultList)
                    in
                        model
                            |> Main.view
                            |> Query.fromHtml
                            |> Query.find [ dropdownCurrentSelection ]
                            |> Query.children [ class "flag-icon-au" ]
                            |> Query.count (Expect.equal 1)
                )
            , fuzz3
                config
                location
                surveyResultList
                "shows the Italian flag for the Italian language"
                (\config location surveyResultList ->
                    let
                        locale =
                            (Locale It False)

                        model =
                            Model
                                config
                                locale
                                location
                                ListSurveyResultsRoute
                                NotRequested
                                (Success surveyResultList)
                    in
                        model
                            |> Main.view
                            |> Query.fromHtml
                            |> Query.find [ dropdownCurrentSelection ]
                            |> Query.children [ class "flag-icon-it" ]
                            |> Query.count (Expect.equal 1)
                )
            , fuzz3
                config
                location
                surveyResultList
                "shows the Japanese flag for the Japanese language"
                (\config location surveyResultList ->
                    let
                        locale =
                            (Locale Ja False)

                        model =
                            Model
                                config
                                locale
                                location
                                ListSurveyResultsRoute
                                NotRequested
                                (Success surveyResultList)
                    in
                        model
                            |> Main.view
                            |> Query.fromHtml
                            |> Query.find [ dropdownCurrentSelection ]
                            |> Query.children [ class "flag-icon-jp" ]
                            |> Query.count (Expect.equal 1)
                )
            ]


openDropdownTest :
    Fuzzer Config
    -> Fuzzer Location
    -> Fuzzer SurveyResultList
    -> Test
openDropdownTest config location surveyResultList =
    let
        dropdownMenu =
            Selector.attribute
                (Attributes.attribute
                    "data-name"
                    "locale-dropdown-menu"
                )

        language =
            Lang.fuzzer
    in
        describe "clicking the language dropdown menu"
            [ fuzz4
                config
                location
                language
                surveyResultList
                """
                sends a message to toggle the display of the available languages
                """
                (\config location language surveyResultList ->
                    let
                        locale =
                            Locale language False

                        model =
                            Model
                                config
                                locale
                                location
                                ListSurveyResultsRoute
                                NotRequested
                                (Success surveyResultList)
                    in
                        model
                            |> Main.view
                            |> Query.fromHtml
                            |> Query.find [ dropdownMenu ]
                            |> Event.simulate click
                            |> Event.expect (LocaleMsg ToggleAvailableLanguages)
                )
            ]


changeLanguageTest :
    Fuzzer Config
    -> Fuzzer Location
    -> Fuzzer SurveyResultList
    -> Test
changeLanguageTest config location surveyResultList =
    let
        dropdownList =
            Selector.attribute
                (Attributes.attribute
                    "data-name"
                    "locale-dropdown-list"
                )
    in
        describe "changing language"
            [ fuzz3
                config
                location
                surveyResultList
                "changing to Italian"
                (\config location surveyResultList ->
                    let
                        locale =
                            (Locale En False)

                        model =
                            Model
                                config
                                locale
                                location
                                ListSurveyResultsRoute
                                NotRequested
                                (Success surveyResultList)

                        italianDropdownOption =
                            Selector.attribute
                                (Attributes.attribute
                                    "data-name"
                                    "language-it"
                                )
                    in
                        model
                            |> Main.view
                            |> Query.fromHtml
                            |> Query.find [ dropdownList ]
                            |> Query.find [ italianDropdownOption ]
                            |> Event.simulate click
                            |> Event.expect (LocaleMsg (ChangeLanguage It))
                )
            , fuzz3
                config
                location
                surveyResultList
                "changing to Japanese"
                (\config location surveyResultList ->
                    let
                        locale =
                            (Locale En False)

                        model =
                            Model
                                config
                                locale
                                location
                                ListSurveyResultsRoute
                                NotRequested
                                (Success surveyResultList)

                        japaneseDropdownOption =
                            Selector.attribute
                                (Attributes.attribute
                                    "data-name"
                                    "language-ja"
                                )
                    in
                        model
                            |> Main.view
                            |> Query.fromHtml
                            |> Query.find [ dropdownList ]
                            |> Query.find [ japaneseDropdownOption ]
                            |> Event.simulate click
                            |> Event.expect (LocaleMsg (ChangeLanguage Ja))
                )
            ]
