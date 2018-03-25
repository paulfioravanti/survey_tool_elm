module SurveyResultList.View exposing (view)

import Html exposing (Html, div, h1, img, section, text)
import Html.Attributes exposing (alt, attribute, class, src)
import SurveyResult.Model exposing (SurveyResult)
import SurveyResult.View


view : Html msg
view =
    let
        articleClasses =
            [ "avenir"
            , "b--black-10"
            , "ba"
            , "grow grow:active grow:focus"
            , "hover-bg-washed-red"
            , "ma2 mt2-ns"
            , "pa2"
            ]
                |> String.join " "

        surveyResults =
            [ SurveyResult
                "Simple Survey"
                "6"
                "83%"
                "5"
                "/survey_results/1"
            , SurveyResult
                "Acme Engagement Survey"
                "271"
                "100%"
                "271"
                "/survey_results/2"
            ]
    in
        section [ attribute "data-name" "survey-results", class "mw7 center" ]
            (div [ class "flex justify-around" ]
                [ heading ]
                :: List.map SurveyResult.View.view surveyResults
            )


heading : Html msg
heading =
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
            [ text "Survey", logo, text "Results" ]


logo : Html msg
logo =
    let
        logoClasses =
            [ "h2 h3-ns"
            , "img"
            , "mh0 mh2-ns"
            , "mt0 mt4-ns"
            ]
                |> String.join " "
    in
        img [ src "/logo.png", class logoClasses, alt "logo" ] []
