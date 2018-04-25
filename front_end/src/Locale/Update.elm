module Locale.Update exposing (update)

import Locale.Cmd as Cmd
import Locale.Model exposing (Locale)
import Locale.Msg exposing (Msg(ChangeLanguage, FetchTranslations))


update : Msg -> Locale -> ( Locale, Cmd Msg )
update msg locale =
    case msg of
        ChangeLanguage language location ->
            ( { locale | language = language }, Cmd.fetchTranslations language )

        FetchTranslations (Ok translations) ->
            ( { locale | translations = translations }, Cmd.none )

        FetchTranslations (Err msg) ->
            ( locale, Cmd.none )
