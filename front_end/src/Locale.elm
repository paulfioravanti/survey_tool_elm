module Locale exposing (Locale, Msg, init, fetchTranslations, update)

import I18Next
import Json.Decode as Decode
import Locale.Cmd as Cmd
import Locale.Model as Model exposing (Language(En, Ja))
import Locale.Msg as Msg
import Locale.Update as Update


type alias Language =
    Model.Language


type alias Locale =
    Model.Locale


type alias Msg =
    Msg.Msg


init : Decode.Value -> Locale
init languageFlag =
    let
        language =
            languageFlag
                |> Decode.decodeValue Decode.string
                |> toLanguage

        translations =
            I18Next.initialTranslations
    in
        { language = language
        , translations = translations
        }


fetchTranslations : Language -> Cmd Msg
fetchTranslations language =
    Cmd.fetchTranslations language


update : Msg -> Locale -> ( Locale, Cmd Msg )
update msg locale =
    Update.update msg locale


toLanguage : Result error String -> Language
toLanguage language =
    case language of
        Ok language ->
            if String.startsWith "en" language then
                En
            else if String.startsWith "ja" language then
                Ja
            else
                En

        Err _ ->
            En
