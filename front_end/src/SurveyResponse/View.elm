module SurveyResponse.View exposing (view)

{-| Display a survey response.
-}

import Css exposing (hover, visible, visibility)
import Css.Foreign exposing (children)
import Html.Styled exposing (Html, a, div, text)
import Html.Styled.Attributes exposing (attribute, class, css, href)
import Html.Styled.Events exposing (onMouseEnter)
import I18Next exposing (Translations)
import Styles
import SurveyResponse.Model exposing (Rating)
import SurveyResponse.RespondentHistogram exposing (RespondentHistogram)
import SurveyResponse.Tooltip as Tooltip
import SurveyResultDetail.Config exposing (Config)


view : Config msg -> Translations -> RespondentHistogram -> Rating -> Html msg
view config translations respondents rating =
    let
        classes =
            [ "dt"
            , "mh1"
            , "no-underline"
            ]
                |> String.join " "
                |> class

        styles =
            [ hover
                [ children
                    [ Css.Foreign.selector
                        "[data-name='survey-response-content']"
                        [ Styles.brandBackgroundColor ]
                    ]
                ]
            ]
                |> css
    in
        div
            [ attribute "data-name" "survey-response"
            , classes
            , styles
            ]
            [ content config translations respondents rating ]


content : Config msg -> Translations -> RespondentHistogram -> Rating -> Html msg
content config translations respondents rating =
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
                |> class

        styles =
            [ hover
                [ Styles.brandBorderColor
                , children
                    [ Css.Foreign.selector
                        "[data-name*='survey-response-tooltip']"
                        [ visibility visible ]
                    ]
                ]
            ]
                |> css
    in
        div
            [ attribute "data-name" "survey-response-content"
            , classes
            , styles
            , onMouseEnter config.blurMsg
            ]
            [ text rating
            , Tooltip.view translations rating respondents
            ]
