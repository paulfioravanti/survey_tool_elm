module SurveyResultList.View exposing (view)

{-| Display a survey result list
-}

import Css exposing (..)
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
import Locale exposing (Language)
import SurveyResult exposing (SurveyResult)
import SurveyResultList.Config exposing (Config)
import SurveyResultList.Context exposing (Context)
import SurveyResultList.Model exposing (SurveyResultList)


view : Config msg -> Context -> SurveyResultList -> Html msg
view config context { surveyResults } =
    let
        classes =
            [ "center"
            , "mw7"
            ]
                |> String.join " "
                |> class
    in
        main_ []
            [ header config context
            , section [ attribute "data-name" "survey-results", classes ]
                (surveyResultList config context surveyResults)
            ]


header : Config msg -> Context -> Html msg
header config context =
    let
        dropdownConfig =
            { localeMsg = config.localeMsg
            , updatePageMsg = config.updatePageMsg
            }

        dropdownContext =
            { location = context.location }
    in
        nav [ class "flex flex-row justify-between mw8 center mt1" ]
            [ logo
            , Locale.dropdown dropdownConfig dropdownContext
            ]


surveyResultList :
    Config msg
    -> Context
    -> List SurveyResult
    -> List (Html msg)
surveyResultList config context surveyResults =
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
            [ heading context.locale.translations ]
            :: (surveyResults
                    |> List.map
                        (SurveyResult.view
                            surveyResultConfig
                            context.locale.translations
                        )
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
        h1 [ class headingClasses, css [ fontSize (Css.rem 4.0) ] ]
            [ text (I18Next.t translations "surveyResults") ]


logo : Html msg
logo =
    let
        logoClasses =
            [ "h2 h2-ns"
            , "img"
            , "mh1 mh2-ns"
            , "mt0"
            ]
                |> String.join " "
    in
        img [ src "/logo.png", class logoClasses, alt "logo" ] []
