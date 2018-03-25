module SurveyResultList.View exposing (view)

import Html exposing (Html, div, h1, img, section, text)
import Html.Attributes exposing (alt, attribute, class, src)
import SurveyResult.View


view : Html msg
view =
    section [ attribute "data-name" "survey-results", class "mw7 center" ]
        [ div [ class "flex justify-around" ]
            [ h1 [ class "avenir dark-gray f2 f-5-ns mv3 ttu" ]
                [ text "Survey", logo, text "Results" ]
            ]
        , SurveyResult.View.view "Simple Survey" "6" "5" "83%"
        , SurveyResult.View.view "Acme Engagement Survey" "271" "271" "100%"
        ]


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
