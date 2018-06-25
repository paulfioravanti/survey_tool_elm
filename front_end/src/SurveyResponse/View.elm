module SurveyResponse.View exposing (view)

{-| Display a survey response.
-}

import Html.Styled exposing (Html, div, text)
import Html.Styled.Attributes exposing (attribute, class, css)
import Html.Styled.Events exposing (onMouseEnter)
import Styles
import SurveyResponse.Model exposing (Rating)
import SurveyResponse.RespondentHistogram exposing (RespondentHistogram)
import SurveyResponse.Tooltip as Tooltip
import Translations exposing (Lang)


view : msg -> Lang -> RespondentHistogram -> Rating -> Html msg
view blurMsg language respondents rating =
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
            [ content blurMsg language respondents rating ]


content :
    msg
    -> Lang
    -> RespondentHistogram
    -> Rating
    -> Html msg
content blurMsg language respondents rating =
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
            , onMouseEnter blurMsg
            ]
            [ text rating
            , Tooltip.view language rating respondents
            ]
