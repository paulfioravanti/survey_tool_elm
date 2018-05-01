module Locale.UpdateTest exposing (suite)

import Config exposing (Config)
import Expect
import Fuzz exposing (Fuzzer)
import Fuzzer.Config as Config
import Fuzzer.Navigation.Location as Location
import Fuzzer.Language as Language
import Fuzzer.Locale as Locale
import Fuzzer.Route as Route
import Http exposing (Error(NetworkError))
import I18Next
import Json.Decode as Decode
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
            , fetchTranslationsSuccessTest config locale location route
            , fetchTranslationsFailureTest config locale location route
            , toggleAvailableLanguagesTest config locale location route
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


fetchTranslationsSuccessTest :
    Fuzzer Config
    -> Fuzzer Locale
    -> Fuzzer Location
    -> Fuzzer Route
    -> Test
fetchTranslationsSuccessTest config locale location route =
    let
        translations =
            """{"foo": "bar", "baz": "qux"}"""
                |> Decode.decodeString I18Next.decodeTranslations
                |> Result.withDefault I18Next.initialTranslations
    in
        describe "when msg is FetchTranslations and fetch is successful"
            [ fuzz4
                config
                locale
                location
                route
                "updates the locale's translations field to the translations"
                (\config locale location route ->
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
                            LocaleMsg (FetchTranslations (Ok translations))

                        newLocale =
                            { locale | translations = translations }
                    in
                        model
                            |> Update.update msg
                            |> Tuple.first
                            |> Expect.equal { model | locale = newLocale }
                )
            ]


fetchTranslationsFailureTest :
    Fuzzer Config
    -> Fuzzer Locale
    -> Fuzzer Location
    -> Fuzzer Route
    -> Test
fetchTranslationsFailureTest config locale location route =
    let
        translations =
            """{"foo": "bar", "baz": "qux"}"""
                |> Decode.decodeString I18Next.decodeTranslations
                |> Result.withDefault I18Next.initialTranslations
    in
        describe "when msg is FetchTranslations and fetch is unsuccessful"
            [ fuzz4
                config
                locale
                location
                route
                "no updates occur to the locale's translations field"
                (\config locale location route ->
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
                            LocaleMsg (FetchTranslations (Err NetworkError))
                    in
                        model
                            |> Update.update msg
                            |> Tuple.first
                            |> Expect.equal model
                )
            ]


toggleAvailableLanguagesTest :
    Fuzzer Config
    -> Fuzzer Locale
    -> Fuzzer Location
    -> Fuzzer Route
    -> Test
toggleAvailableLanguagesTest config locale location route =
    describe "when msg is ToggleAvailableLanguages"
        [ fuzz4
            config
            locale
            location
            route
            """
            updates the locale's showAvailableLanguages field to False when
            original value was True
            """
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
                        LocaleMsg ToggleAvailableLanguages

                    newLocale =
                        { locale | showAvailableLanguages = False }
                in
                    model
                        |> Update.update msg
                        |> Tuple.first
                        |> Expect.equal { model | locale = newLocale }
            )
        , fuzz4
            config
            locale
            location
            route
            """
            updates the locale's showAvailableLanguages field to True when
            original value was False
            """
            (\config locale location route ->
                let
                    model =
                        Model
                            config
                            { locale | showAvailableLanguages = False }
                            location
                            route
                            NotRequested
                            NotRequested

                    msg =
                        LocaleMsg ToggleAvailableLanguages

                    newLocale =
                        { locale | showAvailableLanguages = True }
                in
                    model
                        |> Update.update msg
                        |> Tuple.first
                        |> Expect.equal { model | locale = newLocale }
            )
        ]
