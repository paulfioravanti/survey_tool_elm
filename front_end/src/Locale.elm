module Locale exposing (Language(..), init, translationsUrl)

import Flags exposing (Flags)
import Json.Decode as Decode


type Language
    = En
    | Ja


init : Decode.Value -> Language
init languageFlag =
    let
        language =
            languageFlag
                |> Decode.decodeValue Decode.string
    in
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


translationsUrl : Language -> String
translationsUrl language =
    let
        translationLanguage =
            language
                |> toString
                |> String.toLower
    in
        "/locale/translations." ++ translationLanguage ++ ".json"
