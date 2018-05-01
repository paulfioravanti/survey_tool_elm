module Locale.UpdateTest exposing (suite)

import Config exposing (Config)
import Expect
import Fuzz exposing (Fuzzer)
import Fuzzer.Config as Config
import Fuzzer.Navigation.Location as Location
import Fuzzer.Language as Language
import Fuzzer.Locale as Locale
import Fuzzer.Route as Route
import Locale.Model exposing (Locale)
import Locale.Msg
    exposing
        ( Msg
            ( ChangeLanguage
            , CloseAvailableLanguages
            , FetchTranslations
            , ToggleAvailableLanguages
            )
        )
import Model exposing (Model)
import Msg exposing (Msg(LocaleMsg))
import Navigation exposing (Location)
import RemoteData exposing (RemoteData(NotRequested))
import Route exposing (Route)
import Test exposing (Test, describe, fuzz4, fuzz5)
import Update


suite : Test
suite =
    let
        config =
            Config.fuzzer

        locale =
            Locale.fuzzer

        location =
            Location.fuzzer

        route =
            Route.fuzzer
    in
        describe "update"
            [ changeLanguageTest config locale location route
            , closeAvailableLanguagesTest config locale location route
            ]


changeLanguageTest :
    Fuzzer Config
    -> Fuzzer Locale
    -> Fuzzer Location
    -> Fuzzer Route
    -> Test
changeLanguageTest config locale location route =
    let
        language =
            Language.fuzzer
    in
        describe "when msg is ChangeLanguage"
            [ fuzz5
                config
                locale
                location
                route
                language
                "updates the model language"
                (\config locale location route language ->
                    let
                        model =
                            Model
                                config
                                locale
                                location
                                route
                                NotRequested
                                NotRequested

                        msg =
                            LocaleMsg (ChangeLanguage language)

                        newLocale =
                            { locale | language = language }
                    in
                        model
                            |> Update.update msg
                            |> Tuple.first
                            |> Expect.equal { model | locale = newLocale }
                )
            ]


closeAvailableLanguagesTest :
    Fuzzer Config
    -> Fuzzer Locale
    -> Fuzzer Location
    -> Fuzzer Route
    -> Test
closeAvailableLanguagesTest config locale location route =
    describe "when msg is CloseAvailableLanguages"
        [ fuzz4
            config
            locale
            location
            route
            "updates the locale's showAvailableLanguages field to False"
            (\config locale location route ->
                let
                    model =
                        Model
                            config
                            { locale | showAvailableLanguages = True }
                            location
                            route
                            NotRequested
                            NotRequested

                    msg =
                        LocaleMsg CloseAvailableLanguages

                    newLocale =
                        { locale | showAvailableLanguages = False }
                in
                    model
                        |> Update.update msg
                        |> Tuple.first
                        |> Expect.equal { model | locale = newLocale }
            )
        ]
