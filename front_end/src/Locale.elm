module Locale
    exposing
        ( Language
        , Locale
        , Msg
        , availableLanguages
        , changeLanguageMsg
        , init
        , fetchTranslations
        , languageToFlagClass
        , update
        )

import I18Next
import Json.Decode as Decode exposing (Value)
import Locale.Cmd as Cmd
import Locale.Model as Model exposing (Language(En, It, Ja))
import Locale.Msg as Msg
import Locale.Update as Update


type alias Language =
    Model.Language


type alias Locale =
    Model.Locale


type alias Msg =
    Msg.Msg


availableLanguages : List Language
availableLanguages =
    [ En, It, Ja ]


changeLanguageMsg : Language -> Msg
changeLanguageMsg =
    Msg.ChangeLanguage


init : Value -> Locale
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


languageToFlagClass : Language -> String
languageToFlagClass language =
    let
        flagIconLanguage =
            case language of
                En ->
                    "au"

                It ->
                    "it"

                Ja ->
                    "jp"
    in
        "flag-icon flag-icon-" ++ flagIconLanguage


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
