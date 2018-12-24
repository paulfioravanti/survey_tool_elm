module Header exposing (view)

import Header.Data as Data
import Html.Styled exposing (Html)
import Language exposing (Language)
import LanguageSelector exposing (LanguageSelector)
import RemoteData exposing (WebData)


view :
    (Language -> msg)
    -> (LanguageSelector.Msg -> msg)
    -> Language
    -> LanguageSelector
    -> WebData a
    -> Html msg
view changeLanguageMsg languageSelectorMsg language languageSelector webData =
    Data.view
        changeLanguageMsg
        languageSelectorMsg
        language
        languageSelector
        webData
