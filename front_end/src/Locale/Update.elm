module Locale.Update exposing (update)

import Locale.Model exposing (Locale)
import Locale.Msg exposing (Msg(FetchTranslations))


update : Msg -> Locale -> ( Locale, Cmd Msg )
update msg locale =
    case msg of
        FetchTranslations (Ok translations) ->
            ( { locale | translations = translations }, Cmd.none )

        FetchTranslations (Err msg) ->
            ( locale, Cmd.none )
