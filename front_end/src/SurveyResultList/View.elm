module SurveyResultList.View exposing (view, warningMessage)

import Html exposing (Html, div, h1, h4, i, img, section, span, text)
import Html.Attributes exposing (alt, attribute, class, src)
import SurveyResult.View
import SurveyResultList.Model exposing (SurveyResultList)


view : SurveyResultList -> Html msg
view surveyResultList =
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
    in
        section [ attribute "data-name" "survey-results", class "mw7 center" ]
            (div [ class "flex justify-around" ]
                [ heading ]
                :: (surveyResultList.surveyResults
                        |> List.map SurveyResult.View.view
                   )
            )


warningMessage : String -> String -> Html msg -> Html msg
warningMessage iconClasses message content =
    div [ class "warning" ]
        [ span [ class "fa-stack" ]
            [ i [ class iconClasses ] [] ]
        , h4 []
            [ text message ]
        , content
        ]


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
