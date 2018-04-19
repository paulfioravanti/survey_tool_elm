module SurveyResponse.View exposing (view)

{-| Display a survey response.
-}

import Css exposing (hover, visible, visibility)
import Css.Foreign exposing (children)
import Html.Styled exposing (Html, a, div, text)
import Html.Styled.Attributes exposing (attribute, class, css, href)
import I18Next exposing (Translations)
import Styles
import SurveyResponse.Model exposing (Rating)
import SurveyResponse.RespondentHistogram exposing (RespondentHistogram)
import SurveyResponse.Tooltip as Tooltip


view : Translations -> RespondentHistogram -> Rating -> Html msg
view translations respondents rating =
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
            ]
    in
        div
            [ attribute "data-name" "survey-response"
            , class classes
            , css styles
            ]
            [ content translations respondents rating ]


content : Translations -> RespondentHistogram -> Rating -> Html msg
content translations respondents rating =
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
            , Tooltip.view translations rating respondents
            ]
