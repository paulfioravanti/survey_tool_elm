module Locale.Dropdown exposing (view)

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
    in
        div
            [ attribute "data-name" "locale-dropdown-menu"
            , classes
            , css [ Styles.dropdownMenu ]
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
    in
        span
            [ attribute "data-name" "locale-dropdown-caret"
            , classes
            , css [ Styles.dropdownMenuCaret ]
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
            , css [ Styles.dropdownMenuList ]
            ]
            (List.map (dropdownListItemView localeMsg) selectableLanguages)


dropdownListItemView : (Msg -> msg) -> Language -> Html msg
dropdownListItemView localeMsg language =
    let
        classes =
            [ "pa2", "w-100" ]
                |> String.join " "
                |> class
    in
        li
            [ classes
            , css [ Styles.dropdownMenuListItem ]
            , onClick (localeMsg (ChangeLanguage language))
            ]
            [ span [ class (Utils.languageToFlagClass language) ] [] ]
