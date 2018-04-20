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
        , section
        , span
        , text
        , ul
        )
import Html.Styled.Attributes exposing (alt, attribute, class, css, href, src)
import I18Next exposing (Translations)
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
    nav [ class "flex flex-row-reverse h3 mw8 center" ]
        [ ul [ class "list pa0" ]
            [ li
                [ class "pv2 ph4 b--white ba"
                , css
                    [ hover
                        [ borderColor (rgba 0 0 0 0.1)
                          -- , Css.Foreign.children
                          --     [ Css.Foreign.class "locale-list"
                          --         [ display block ]
                          --     ]
                        ]
                    ]
                ]
                [ div [ class "flag-icon flag-icon-au f3" ]
                    []
                , div [ class "dn locale-list" ]
                    [ ul [ class "list pa0" ]
                        [ li []
                            [ div [ class "flag-icon flag-icon-jp f3" ]
                                []
                            ]
                        ]
                    ]
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
