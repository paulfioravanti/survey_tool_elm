module Locale.Dropdown exposing (view)

import Css exposing (..)
import Css.Foreign
import Html.Styled exposing (Html, div, li, p, span, text, ul)
import Html.Styled.Attributes exposing (attribute, class, css)
import Html.Styled.Events exposing (onClick)
import Locale.Model as Model exposing (Language(En, It, Ja), Locale)
import Locale.Msg exposing (Msg(ChangeLanguage, ToggleAvailableLanguages))
import Locale.Utils as Utils
import Styles


view : (Msg -> msg) -> Locale -> Html msg
view localeMsg locale =
    let
        classes =
            [ "relative", "pointer", "w3" ]
                |> String.join " "
                |> class

        styles =
            [ hover
                [ Css.Foreign.children
                    [ Css.Foreign.selector
                        "[data-name='locale-dropdown-current-selection']"
                        [ borderColor (rgba 0 0 0 0.1) ]
                    ]
                , Css.Foreign.descendants
                    [ Css.Foreign.selector
                        "[data-name='locale-dropdown-caret']"
                        [ color (rgba 0 0 0 0.2) ]
                    ]
                ]
            ]
                |> css
    in
        div
            [ attribute "data-name" "locale-dropdown-menu"
            , classes
            , styles
            , onClick (localeMsg ToggleAvailableLanguages)
            ]
            [ currentSelection locale
            , dropdownList localeMsg locale
            ]


currentSelection : Locale -> Html msg
currentSelection locale =
    let
        displayClasses =
            if locale.showAvailableLanguages then
                [ "b--black-10" ]
            else
                [ "b--white" ]

        classes =
            [ "ba"
            , "bg-white"
            , "flex"
            , "items-center"
            , "light-silver"
            , "mv0"
            , "pa2"
            , "tc"
            ]
                ++ displayClasses
                |> String.join " "
                |> class

        flagClasses =
            [ "flex-auto"
            , Utils.languageToFlagClass locale.language
            ]
                |> String.join " "
                |> class
    in
        p
            [ attribute "data-name" "locale-dropdown-current-selection"
            , classes
            ]
            [ span [ flagClasses ] []
            , caret locale
            ]


caret : Locale -> Html msg
caret locale =
    let
        displayClasses =
            if locale.showAvailableLanguages then
                [ "black-20" ]
            else
                [ "white" ]

        classes =
            [ "absolute" ]
                ++ displayClasses
                |> String.join " "
                |> class

        styles =
            [ left (pct 80) ]
                |> css
    in
        span
            [ attribute "data-name" "locale-dropdown-caret"
            , classes
            , styles
            ]
            [ text "▾" ]


dropdownList : (Msg -> msg) -> Locale -> Html msg
dropdownList localeMsg locale =
    let
        displayClasses =
            if locale.showAvailableLanguages then
                [ "flex", "flex-column" ]
            else
                [ "dn" ]

        classes =
            [ "absolute"
            , "b--black-10"
            , "bb"
            , "bg-white"
            , "bl"
            , "br"
            , "items-center"
            , "list"
            , "ma0"
            , "pa0"
            , "tc"
            , "top-2"
            , "w3"
            ]
                ++ displayClasses
                |> String.join " "
                |> class

        selectableLanguages =
            List.filter
                (\language -> language /= locale.language)
                Model.availableLanguages
    in
        ul
            [ attribute "data-name" "locale-dropdown-list"
            , classes
            , css [ marginTop (Css.rem 0.12) ]
            ]
            (List.map (dropdownListItemView localeMsg) selectableLanguages)


dropdownListItemView : (Msg -> msg) -> Language -> Html msg
dropdownListItemView localeMsg language =
    li
        [ class "pa2 w-100"
        , css [ hover [ Styles.brandBackgroundColorAlpha ] ]
        , onClick (localeMsg (ChangeLanguage language))
        ]
        [ span [ class (Utils.languageToFlagClass language) ] [] ]
