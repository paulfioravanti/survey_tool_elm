module Locale.Update exposing (update)

import Locale.Cmd as Cmd
import Locale.Model exposing (Locale)
import Locale.Msg
    exposing
        ( Msg
            ( ChangeLanguage
            , CloseAvailableLanguages
            , ToggleAvailableLanguages
            )
        )


update : Msg -> Locale -> ( Locale, Cmd Msg )
update msg ({ showAvailableLanguages } as locale) =
    case msg of
        ChangeLanguage language ->
            ( { locale | language = language }
            , language
                |> toString
                |> String.toLower
                |> Cmd.updateLanguage
            )

        CloseAvailableLanguages ->
            ( { locale | showAvailableLanguages = False }, Cmd.none )

        ToggleAvailableLanguages ->
            ( { locale | showAvailableLanguages = not showAvailableLanguages }
            , Cmd.none
            )
