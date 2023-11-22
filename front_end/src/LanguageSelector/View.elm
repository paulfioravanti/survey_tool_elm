module LanguageSelector.View exposing (view)

import Html.Styled exposing (Attribute, Html, div, li, p, span, text, ul)
import Html.Styled.Attributes exposing (attribute, class, css)
import Html.Styled.Events exposing (onClick, onMouseLeave)
import Language exposing (Language)
import LanguageSelector.Model exposing (LanguageSelector)
import LanguageSelector.Msg as Msg exposing (Msg)
import LanguageSelector.Styles as Styles


{-| The language selector needs to be able to send messages to both the
handlers for ChangeLanguage and LanguageSelector messages.
-}
view :
    (Language -> msg)
    -> (Msg -> msg)
    -> Language
    -> LanguageSelector
    -> Html msg
view changeLanguageMsg languageSelectorMsg language languageSelector =
    let
        {- If the language selector is open and the user decides to not
           select a language, then the dropdown menu should close.
        -}
        hideSelectableLanguages : List (Attribute msg)
        hideSelectableLanguages =
            if languageSelector.showSelectableLanguages then
                [ onMouseLeave
                    (Msg.hideSelectableLanguages languageSelectorMsg)
                ]

            else
                []
    in
    div
        ([ attribute "data-name" "language-selector"
         , class Styles.dropdownMenu
         , css [ Styles.dropdownMenuCss ]
         ]
            ++ hideSelectableLanguages
        )
        [ currentSelection languageSelectorMsg language languageSelector
        , dropdownList changeLanguageMsg languageSelector
        ]


currentSelection : (Msg -> msg) -> Language -> LanguageSelector -> Html msg
currentSelection languageSelectorMsg language { showSelectableLanguages } =
    let
        flagStyles : String
        flagStyles =
            language
                |> Language.toFlagClass
                |> Styles.countryFlag
    in
    p
        [ attribute "data-name" "language-selector-current-selection"
        , class (Styles.currentSelection showSelectableLanguages)
        , onClick (Msg.toggleSelectableLanguages languageSelectorMsg)
        ]
        [ span [ class flagStyles ] []
        , caret showSelectableLanguages
        ]


caret : Bool -> Html msg
caret showSelectableLanguages =
    span
        [ attribute "data-name" "language-selector-caret"
        , class (Styles.dropdownMenuCaret showSelectableLanguages)
        , css [ Styles.dropdownMenuCaretCss ]
        ]
        [ text "▾" ]


dropdownList : (Language -> msg) -> LanguageSelector -> Html msg
dropdownList changeLanguageMsg languageSelector =
    let
        { selectableLanguages, showSelectableLanguages } =
            languageSelector
    in
    ul
        [ attribute "data-name" "language-selector-list"
        , class (Styles.dropdownMenuList showSelectableLanguages)
        , css [ Styles.dropdownMenuListCss showSelectableLanguages ]
        ]
        (selectableLanguages
            |> List.map (dropdownListItem changeLanguageMsg)
        )


dropdownListItem : (Language -> msg) -> Language -> Html msg
dropdownListItem changeLanguageMsg language =
    let
        attributeName : String
        attributeName =
            Language.toString language

        flagClasses : String
        flagClasses =
            language
                |> Language.toFlagClass
                |> Styles.countryFlag
    in
    li
        [ attribute "data-name" ("language-" ++ attributeName)
        , class Styles.dropdownMenuListItem
        , css [ Styles.dropdownMenuListItemCss ]
        , onClick (changeLanguageMsg language)
        ]
        [ span [ class flagClasses ] [] ]
