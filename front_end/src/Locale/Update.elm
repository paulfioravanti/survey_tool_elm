module Locale.Update exposing (update)

import Locale.Model exposing (Locale)
import Locale.Msg exposing (Msg(TranslationsLoaded))


update : Msg -> Locale -> ( Locale, Cmd Msg )
update msg locale =
    case msg of
        TranslationsLoaded (Ok translations) ->
            ( { locale | translations = translations }, Cmd.none )

        TranslationsLoaded (Err msg) ->
            ( locale, Cmd.none )
