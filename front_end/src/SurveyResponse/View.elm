module SurveyResponse.View exposing (view)

import Html.Styled exposing (Html, div, text)
import Html.Styled.Attributes exposing (attribute, class, css)
import Language exposing (Language)
import SurveyResponse.RespondentHistogram exposing (RespondentHistogram)
import SurveyResponse.Styles as Styles
import SurveyResponse.Tooltip.View as Tooltip


view : Language -> RespondentHistogram -> String -> Html msg
view language respondents rating =
    div
        [ attribute "data-name" "survey-response"
        , class Styles.surveyResponse
        , css [ Styles.surveyResponseCss ]
        ]
        [ content language respondents rating ]


content : Language -> RespondentHistogram -> String -> Html msg
content language respondents rating =
    div
        [ attribute "data-name" "survey-response-content"
        , class Styles.surveyResponseContent
        , css [ Styles.surveyResponseContentCss ]
        ]
        [ text rating
        , Tooltip.view language rating respondents
        ]
