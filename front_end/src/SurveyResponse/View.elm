module SurveyResponse.View exposing (view)

{-| Display a survey response.
-}

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
    in
        div
            [ attribute "data-name" "survey-response"
            , classes
            , css [ Styles.surveyResponse ]
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
    in
        div
            [ attribute "data-name" "survey-response-content"
            , classes
            , css [ Styles.surveyResponseContent ]
            , onMouseEnter config.blurMsg
            ]
            [ text rating
            , Tooltip.view translations rating respondents
            ]
