port module Locale.Cmd exposing (fetchTranslations, updateLanguage)

import I18Next
import Locale.Msg as Msg exposing (Msg(FetchTranslations))
import Translations exposing (Lang)


port updateLanguage : String -> Cmd msg


fetchTranslations : Lang -> Cmd Msg
fetchTranslations language =
    language
        |> toTranslationsUrl
        |> I18Next.fetchTranslations FetchTranslations


toTranslationsUrl : Lang -> String
toTranslationsUrl language =
    let
        translationLanguage =
            language
                |> toString
                |> String.toLower
    in
        "/locale/translations." ++ translationLanguage ++ ".json"
