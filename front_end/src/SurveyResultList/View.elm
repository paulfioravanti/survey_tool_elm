module SurveyResultList.View exposing (view)

{-| Display a survey result list
-}

import Header
import Html.Styled
    exposing
        ( Attribute
        , Html
        , div
        , h1
        , main_
        , section
        , text
        )
import Html.Styled.Attributes exposing (attribute, class, css)
import Html.Styled.Events exposing (onWithOptions)
import Json.Decode as Decode
import Locale exposing (Locale)
import Styles
import SurveyResult exposing (SurveyResult)
import SurveyResultList.Config exposing (Config)
import SurveyResultList.Model exposing (SurveyResultList)
import Translations exposing (Lang)


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
            [ Header.view localeMsg locale
            , section
                [ attribute "data-name" "survey-results"
                , classes
                , blurClickOptions
                ]
                (surveyResultList surveyResultDetailMsg locale surveyResults)
            ]


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
            [ heading locale.language ]
            :: (surveyResults
                    |> List.map
                        (SurveyResult.view
                            surveyResultDetailMsg
                            locale.language
                        )
               )


heading : Lang -> Html msg
heading language =
    let
        headingClasses =
            [ "avenir"
            , "dark-gray"
            , "mv3"
            , "ttu"
            ]
                |> String.join " "
                |> class
    in
        h1
            [ headingClasses, css [ Styles.surveyResultListHeading ] ]
            [ text (Translations.surveyResults language) ]


msgClickOptions : msg -> Attribute msg
msgClickOptions msg =
    onWithOptions
        "click"
        { preventDefault = True, stopPropagation = True }
        (Decode.succeed msg)
