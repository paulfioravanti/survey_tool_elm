module Locale.UpdateTest exposing (suite)

import Config exposing (Config)
import Expect
import Fuzz exposing (Fuzzer)
import Fuzzer.Config as Config
import Fuzzer.Navigation.Location as Location
import Fuzzer.Lang as Lang
import Fuzzer.Locale as Locale
import Fuzzer.Route as Route
import Http exposing (Error(NetworkError))
import Json.Decode as Decode
import Locale.Model exposing (Locale)
import Locale.Msg
    exposing
        ( Msg
            ( ChangeLanguage
            , CloseAvailableLanguages
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
            Lang.fuzzer
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
