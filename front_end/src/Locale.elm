module Locale exposing (Locale(..), init, translationsUrl)

import Flags exposing (Flags)
import Json.Decode as Decode


type Locale
    = En
    | Ja


init : Decode.Value -> Locale
init localeFlag =
    let
        locale =
            localeFlag
                |> Decode.decodeValue Decode.string
    in
        case locale of
            Ok locale ->
                if String.startsWith "en" locale then
                    En
                else if String.startsWith "ja" locale then
                    Ja
                else
                    En

            Err _ ->
                En


translationsUrl : Locale -> String
translationsUrl locale =
    let
        translationLocale =
            locale
                |> toString
                |> String.toLower
    in
        "/locale/translations." ++ translationLocale ++ ".json"
