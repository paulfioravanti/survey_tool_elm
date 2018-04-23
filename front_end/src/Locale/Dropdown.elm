module Locale.Dropdown exposing (view)

import Css exposing (..)
import Css.Foreign
import Html.Styled
    exposing
        ( Html
        , a
        , div
        , h1
        , h4
        , img
        , li
        , main_
        , nav
        , p
        , section
        , span
        , text
        , ul
        )
import Html.Styled.Attributes exposing (alt, attribute, class, css, href, src)
import Html.Styled.Events exposing (onMouseOver)
import Locale.Model as Model exposing (Config, Language(En, It, Ja))
import Styles


view : Config msg -> Html msg
view config =
    div
        [ class "relative w3 pointer"
        , css
            [ hover
                [ Css.Foreign.children
                    [ Css.Foreign.selector
                        "[data-name='locale-dropdown-menu']"
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
        ]
        [ p
            [ attribute "data-name" "locale-dropdown-menu"
            , class "tc pa2 bg-white flex items-center b--white ba light-silver mv0"
            ]
            [ span [ class "flex-auto flag-icon flag-icon-au" ] []
            , span
                [ attribute "data-name" "locale-dropdown-caret"
                , class "white absolute"
                , css [ left (pct 80) ]
                ]
                [ text "▾" ]
            ]
        , ul
            [ attribute "data-name" "locale-dropdown-list"
            , class "dn absolute list ma0 pa0 tc top-2 w3 b--black-10 bb bl br items-center"
            , css [ marginTop (Css.rem 0.12) ]
            ]
            (List.map
                (dropdownListItemView config)
                Model.availableLanguages
            )
        ]


dropdownListItemView : Config msg -> Language -> Html msg
dropdownListItemView { changeLanguageMsg } language =
    li
        [ class "pa2 w-100"
        , css [ hover [ Styles.brandBackgroundColorAlpha ] ]
        , onMouseOver (changeLanguageMsg language)
        ]
        [ span [ class (languageToFlagClass language) ] [] ]


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
