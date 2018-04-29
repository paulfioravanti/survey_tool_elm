module Locale.Update exposing (update)

import Locale.Cmd as Cmd
import Locale.Model exposing (Locale)
import Locale.Msg
    exposing
        ( Msg
            ( ChangeLanguage
            , FetchTranslations
            , ToggleAvailableLanguages
            )
        )


update : Msg -> Locale -> ( Locale, Cmd Msg )
update msg locale =
    case msg of
        ChangeLanguage language ->
            ( { locale | language = language }, Cmd.fetchTranslations language )

        FetchTranslations (Ok translations) ->
            ( { locale | translations = translations }, Cmd.none )

        FetchTranslations (Err msg) ->
            ( locale, Cmd.none )

        ToggleAvailableLanguages ->
            ( { locale
                | showAvailableLanguages = not locale.showAvailableLanguages
              }
            , Cmd.none
            )
