module SurveyResultList.View exposing (view)

{-| Display a survey result list
-}

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
import Html.Styled.Events exposing (onClick)
import I18Next exposing (Translations)
import Styles
import SurveyResult exposing (SurveyResult)
import SurveyResultList.Model exposing (Config, SurveyResultList)


view : Config msg -> Translations -> SurveyResultList -> Html msg
view config translations { surveyResults } =
    let
        classes =
            [ "center"
            , "mw7"
            ]
                |> String.join " "
                |> class
    in
        main_ []
            [ navigation config
            , section [ attribute "data-name" "survey-results", classes ]
                (surveyResultList config translations surveyResults)
            ]


navigation : Config msg -> Html msg
navigation { changeLanguageMsg } =
    nav [ class "flex flex-row-reverse mw8 center mt1" ]
        [ div
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
                [ li
                    [ class "pa2 w-100"
                    , css [ hover [ Styles.brandBackgroundColorAlpha ] ]
                    , onClick changeLanguageMsg
                    ]
                    [ span [ class "flag-icon flag-icon-it" ] [] ]
                , li
                    [ class "pa2 w-100"
                    , css [ hover [ Styles.brandBackgroundColorAlpha ] ]
                    , onClick changeLanguageMsg
                    ]
                    [ span [ class "flag-icon flag-icon-jp" ] [] ]
                ]
            ]
        ]


surveyResultList :
    Config msg
    -> Translations
    -> List SurveyResult
    -> List (Html msg)
surveyResultList config translations surveyResults =
    let
        classes =
            [ "flex"
            , "justify-around"
            , "mt1"
            ]
                |> String.join " "
                |> class

        surveyResultConfig =
            { surveyResultDetailMsg = config.surveyResultDetailMsg }
    in
        div [ classes ]
            [ heading translations ]
            :: (surveyResults
                    |> List.map
                        (SurveyResult.view surveyResultConfig translations)
               )


heading : Translations -> Html msg
heading translations =
    let
        headingClasses =
            [ "avenir"
            , "dark-gray"
            , "f2 f-5-ns"
            , "mv3"
            , "ttu"
            ]
                |> String.join " "
    in
        h1 [ class headingClasses ]
            [ text (I18Next.t translations "survey")
            , logo
            , text (I18Next.t translations "results")
            ]


logo : Html msg
logo =
    let
        logoClasses =
            [ "h2 h3-ns"
            , "img"
            , "mh1 mh2-ns"
            , "mt0"
            ]
                |> String.join " "
    in
        img [ src "/logo.png", class logoClasses, alt "logo" ] []
