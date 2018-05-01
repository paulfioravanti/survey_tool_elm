module Locale.Update exposing (update)

import Locale.Cmd as Cmd
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


update : Msg -> Locale -> ( Locale, Cmd Msg )
update msg ({ showAvailableLanguages } as locale) =
    case msg of
        ChangeLanguage language ->
            ( { locale | language = language }
            , Cmd.batch
                [ Cmd.fetchTranslations language
                , language
                    |> toString
                    |> String.toLower
                    |> Cmd.updateLanguage
                ]
            )

        CloseAvailableLanguages ->
            ( { locale | showAvailableLanguages = False }, Cmd.none )

        FetchTranslations (Ok translations) ->
            ( { locale | translations = translations }, Cmd.none )

        FetchTranslations (Err msg) ->
            ( locale, Cmd.none )

        ToggleAvailableLanguages ->
            ( { locale | showAvailableLanguages = not showAvailableLanguages }
            , Cmd.none
            )
