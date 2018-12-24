module Header.View exposing (view)

{-| Header view content.
-}

import Header.Styles as Styles
import Html.Styled exposing (Html, header)
import Html.Styled.Attributes exposing (class)
import Language exposing (Language)
import LanguageSelector exposing (LanguageSelector)


view :
    (Language -> msg)
    -> (LanguageSelector.Msg -> msg)
    -> Language
    -> LanguageSelector
    -> Html msg
view changeLanguageMsg languageSelectorMsg language languageSelector =
    header [ class Styles.layout ]
        [ LanguageSelector.view
            changeLanguageMsg
            languageSelectorMsg
            language
            languageSelector
        ]
