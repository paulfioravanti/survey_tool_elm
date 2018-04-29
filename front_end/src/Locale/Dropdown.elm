module Locale.Dropdown exposing (view)

import Css exposing (..)
import Css.Foreign
import Html.Styled exposing (Html, div, li, p, span, text, ul)
import Html.Styled.Attributes exposing (attribute, class, css)
import Html.Styled.Events exposing (onClick)
import Locale.Config exposing (Config)
import Locale.Context exposing (Context)
import Locale.Model as Model exposing (Language(En, It, Ja))
import Locale.Msg exposing (Msg(ChangeLanguage))
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
            [ currentSelection context
            , dropdownList config context
            ]


currentSelection : Context -> Html msg
currentSelection context =
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

        flagClasses =
            [ "flex-auto"
            , Utils.languageToFlagClass context.locale.language
            ]
                |> String.join " "
                |> class
    in
        p
            [ attribute "data-name" "locale-dropdown-current-selection"
            , classes
            ]
            [ span [ flagClasses ] []
            , caret
            ]


caret : Html msg
caret =
    let
        classes =
            [ "absolute", "white" ]
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


dropdownList : Config msg -> Context -> Html msg
dropdownList config context =
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

        selectableLanguages =
            List.filter
                (\language -> language /= context.locale.language)
                Model.availableLanguages
    in
        ul
            [ attribute "data-name" "locale-dropdown-list"
            , classes
            , css [ marginTop (Css.rem 0.12) ]
            ]
            (List.map (dropdownListItemView config) selectableLanguages)


dropdownListItemView : Config msg -> Language -> Html msg
dropdownListItemView config language =
    li
        [ class "pa2 w-100"
        , css [ hover [ Styles.brandBackgroundColorAlpha ] ]
        , onClick
            (config.localeMsg (ChangeLanguage language))
        ]
        [ span [ class (Utils.languageToFlagClass language) ] [] ]
