module SurveyResponse.View exposing (view)

import Css exposing (color, hex, hover, visible, visibility)
import Css.Foreign exposing (children)
import Dict exposing (Dict)
import Html.Styled exposing (Html, a, div, text)
import Html.Styled.Attributes exposing (attribute, class, css, href)
import Html.Styled.Events exposing (onWithOptions)
import Json.Decode as Decode
import Styles
import SurveyResponse.Tooltip as Tooltip


view : msg -> Dict String (List Int) -> String -> Html msg
view msg respondents rating =
    let
        classes =
            [ "dt"
            , "mh1"
            , "no-underline"
            ]
                |> String.join " "

        styles =
            [ hover
                [ children
                    [ Css.Foreign.class "survey-response-content"
                        [ Styles.brandBackgroundColor ]
                    ]
                ]
            , color (hex "000")
            ]

        clickOptions =
            onWithOptions
                "click"
                { preventDefault = True, stopPropagation = False }
                (Decode.succeed msg)
    in
        a
            [ attribute "data-name" "survey-response"
            , class classes
            , css styles
            , href "#"
            , clickOptions
              -- , doubleClickOptions
            ]
            [ content respondents rating ]


content : Dict String (List Int) -> String -> Html msg
content respondents rating =
    let
        classes =
            [ "b--light-silver"
            , "ba"
            , "bg-moon-gray"
            , "br4"
            , "dtc"
            , "h2"
            , "hover-white"
            , "pointer"
            , "relative"
            , "tc"
            , "v-mid"
            , "w2"
            ]
                |> String.join " "

        styles =
            [ hover
                [ Styles.brandBorderColor
                , children
                    [ Css.Foreign.class "survey-response-tooltip"
                        [ visibility visible ]
                    ]
                ]
            ]
    in
        div
            [ attribute "data-name" "survey-response-content"
            , class classes
            , class "survey-response-content"
            , css styles
            ]
            [ text rating
            , Tooltip.view rating respondents
            ]
