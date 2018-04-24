module Locale.Dropdown exposing (view)

import Css exposing (..)
import Css.Foreign
import Html.Styled exposing (Html, div, li, p, span, text, ul)
import Html.Styled.Attributes exposing (attribute, class, css)
import Html.Styled.Events exposing (onMouseOver)
import Locale.Config exposing (Config)
import Locale.Context exposing (Context)
import Locale.Model as Model exposing (Language(En, It, Ja))
import Locale.Utils as Utils
import Styles


view : Config msg -> Context -> Html msg
view config context =
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
                        [ borderColor (rgba 0 0 0 0.1)
                        , color (hex "555")
                        ]
                    , Css.Foreign.selector
                        "[data-name='locale-dropdown-list']"
                        [ displayFlex
                        , flexDirection column
                        ]
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
            [ attribute "data-name" "locale-dropdown-menu", classes, styles ]
            [ currentSelection
            , dropdownList config
            ]


currentSelection : Html msg
currentSelection =
    let
        classes =
            [ "b--white"
            , "ba"
            , "bg-white"
            , "flex"
            , "items-center"
            , "light-silver"
            , "mv0"
            , "pa2"
            , "tc"
            ]
                |> String.join " "
                |> class
    in
        p
            [ attribute "data-name" "locale-dropdown-current-selection"
            , classes
            ]
            [ span [ class "flex-auto flag-icon flag-icon-au" ] []
            , caret
            ]


caret : Html msg
caret =
    let
        classes =
            [ "absolute", "white" ]
                |> String.join " "
                |> class
    in
        span
            [ attribute "data-name" "locale-dropdown-caret"
            , classes
            , css [ left (pct 80) ]
            ]
            [ text "▾" ]


dropdownList : Config msg -> Html msg
dropdownList config =
    let
        classes =
            [ "absolute"
            , "b--black-10"
            , "bb"
            , "bg-white"
            , "bl"
            , "br"
            , "dn"
            , "items-center"
            , "list"
            , "ma0"
            , "pa0"
            , "tc"
            , "top-2"
            , "w3"
            ]
                |> String.join " "
                |> class
    in
        ul
            [ attribute "data-name" "locale-dropdown-list"
            , classes
            , css [ marginTop (Css.rem 0.12) ]
            ]
            (List.map (dropdownListItemView config) Model.availableLanguages)


dropdownListItemView : Config msg -> Language -> Html msg
dropdownListItemView { changeLanguageMsg } language =
    li
        [ class "pa2 w-100"
        , css [ hover [ Styles.brandBackgroundColorAlpha ] ]
        , onMouseOver (changeLanguageMsg language)
        ]
        [ span [ class (Utils.languageToFlagClass language) ] [] ]
