module Locale.Cmd exposing (fetchTranslations)

import I18Next
import Locale.Model exposing (Language)
import Locale.Msg as Msg exposing (Msg(FetchTranslations))


fetchTranslations : Language -> Cmd Msg
fetchTranslations language =
    language
        |> translationsUrl
        |> I18Next.fetchTranslations FetchTranslations


translationsUrl : Language -> String
translationsUrl language =
    let
        translationLanguage =
            language
                |> toString
                |> String.toLower
    in
        "/locale/translations." ++ translationLanguage ++ ".json"
