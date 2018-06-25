module Locale
    exposing
        ( Locale
        , Msg
        , closeAvailableLanguagesMsg
        , dropdown
        , init
        , update
        )

import Html.Styled exposing (Html)
import Json.Decode as Decode exposing (Value)
import Locale.Dropdown as Dropdown
import Locale.Model as Model exposing (Locale)
import Locale.Msg as Msg
import Locale.Update as Update
import Translations exposing (Lang(En, It, Ja))


type alias Locale =
    Model.Locale


type alias Msg =
    Msg.Msg


closeAvailableLanguagesMsg : Msg
closeAvailableLanguagesMsg =
    Msg.CloseAvailableLanguages


dropdown : (Msg -> msg) -> Locale -> Html msg
dropdown localeMsg locale =
    Dropdown.view localeMsg locale


init : Value -> Locale
init languageFlag =
    let
        language =
            languageFlag
                |> Decode.decodeValue Decode.string
                |> toLanguage
    in
        { language = language
        , showAvailableLanguages = False
        }


update : Msg -> Locale -> ( Locale, Cmd Msg )
update msg locale =
    Update.update msg locale


toLanguage : Result error String -> Lang
toLanguage languageFlag =
    case languageFlag of
        Ok language ->
            if String.startsWith "en" language then
                En
            else if String.startsWith "it" language then
                It
            else if String.startsWith "ja" language then
                Ja
            else
                En

        Err _ ->
            En
