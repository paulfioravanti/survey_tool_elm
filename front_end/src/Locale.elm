module Locale exposing (Locale, init)

import Flags exposing (Flags)
import Json.Decode as Decode


type Locale
    = En


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
                else
                    En

            Err _ ->
                En
