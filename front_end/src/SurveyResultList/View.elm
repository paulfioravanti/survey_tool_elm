module SurveyResultList.View exposing (view)

{-| Display a survey result list
-}

import Css exposing (..)
import Html.Styled
    exposing
        ( Attribute
        , Html
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
import Html.Styled.Events exposing (onWithOptions)
import I18Next exposing (Translations)
import Json.Decode as Decode
import Locale exposing (Language, Locale)
import SurveyResult exposing (SurveyResult)
import SurveyResultList.Config exposing (Config)
import SurveyResultList.Model exposing (SurveyResultList)


view : Config msg -> Locale -> SurveyResultList -> Html msg
view { blurMsg, localeMsg, surveyResultDetailMsg } locale { surveyResults } =
    let
        classes =
            [ "center"
            , "mw7"
            ]
                |> String.join " "
                |> class

        blurClickOptions =
            msgClickOptions blurMsg
    in
        main_ []
            [ header localeMsg locale
            , section
                [ attribute "data-name" "survey-results"
                , classes
                , blurClickOptions
                ]
                (surveyResultList surveyResultDetailMsg locale surveyResults)
            ]


header : (Locale.Msg -> msg) -> Locale -> Html msg
header localeMsg locale =
    let
        dropdownConfig =
            { localeMsg = localeMsg }
    in
        nav [ class "flex flex-row-reverse mw8 center mt1" ]
            [ Locale.dropdown localeMsg locale ]


surveyResultList :
    (String -> msg)
    -> Locale
    -> List SurveyResult
    -> List (Html msg)
surveyResultList surveyResultDetailMsg locale surveyResults =
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
            [ heading locale.translations ]
            :: (surveyResults
                    |> List.map
                        (SurveyResult.view
                            surveyResultDetailMsg
                            locale.translations
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


msgClickOptions : msg -> Attribute msg
msgClickOptions msg =
    onWithOptions
        "click"
        { preventDefault = True, stopPropagation = True }
        (Decode.succeed msg)
