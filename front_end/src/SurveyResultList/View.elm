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
import I18Next exposing (Translations)
import Styles
import SurveyResult exposing (SurveyResult)
import SurveyResultList.Model exposing (SurveyResultList)


view : (String -> msg) -> Translations -> SurveyResultList -> Html msg
view msg translations { surveyResults } =
    let
        classes =
            [ "center"
            , "mw7"
            ]
                |> String.join " "
                |> class
    in
        main_ []
            [ navigation
            , section [ attribute "data-name" "survey-results", classes ]
                (surveyResultList msg translations surveyResults)
            ]


navigation : Html msg
navigation =
    nav [ class "flex flex-row-reverse mw8 center" ]
        [ div
            [ class "relative w4 pointer"
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
                , class "tc pa2 bg-white flex items-center b--white ba light-silver"
                ]
                [ span [ class "flex-auto" ] [ text "English" ]
                , span
                    [ attribute "data-name" "locale-dropdown-caret"
                    , class "white absolute"
                    , css [ left (pct 88) ]
                    ]
                    [ text "▾" ]
                ]
            , ul
                [ attribute "data-name" "locale-dropdown-list"
                , class "dn absolute list ma0 pa0 tc top-2 w4 b--black-10 bb bl br"
                , css [ marginTop (Css.rem 1.27) ]
                ]
                [ li
                    [ class "pa2 mid-gray hover-white"
                    , css
                        [ hover [ Styles.brandBackgroundColor ]
                        ]
                    ]
                    [ text "Italiano" ]
                , li
                    [ class "pa2 mid-gray hover-white"
                    , css
                        [ hover [ Styles.brandBackgroundColor ]
                        ]
                    ]
                    [ text "日本語" ]
                ]
            ]
        ]


surveyResultList :
    (String -> msg)
    -> Translations
    -> List SurveyResult
    -> List (Html msg)
surveyResultList msg translations surveyResults =
    let
        classes =
            [ "flex"
            , "justify-around"
            , "mt1"
            ]
                |> String.join " "
                |> class
    in
        div [ classes ]
            [ heading translations ]
            :: (surveyResults
                    |> List.map (SurveyResult.view msg translations)
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
