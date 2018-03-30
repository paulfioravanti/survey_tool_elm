module SurveyResultList.View exposing (view)

import Html exposing (Html, div, h1, h4, img, section, span, text)
import Html.Attributes exposing (alt, attribute, class, src)
import SurveyResult.View
import SurveyResultList.Model exposing (SurveyResultList)


view : (String -> msg) -> SurveyResultList -> Html msg
view msg surveyResultList =
    section [ attribute "data-name" "survey-results", class "center mw7" ]
        (div [ class "flex justify-around" ]
            [ heading ]
            :: (surveyResultList.surveyResults
                    |> List.map (SurveyResult.View.view msg)
               )
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
