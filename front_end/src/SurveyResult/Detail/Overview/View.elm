module SurveyResult.Detail.Overview.View exposing (view)

import Html.Styled exposing (Html, div, text)
import Html.Styled.Attributes exposing (attribute, class)
import Language exposing (Language)
import SurveyResult.Detail.Overview.Styles as Styles
import SurveyResult.Model exposing (SurveyResult)
import Translations
import Utils


view : Language -> SurveyResult -> Html msg
view language surveyResult =
    div [ class Styles.summary ]
        [ participationCount language surveyResult.participantCount
        , submittedResponseCount language surveyResult.submittedResponseCount
        , submittedResponseRate language surveyResult.responseRate
        ]



-- PRIVATE


participationCount : Language -> Int -> Html msg
participationCount language participantCount =
    div [ attribute "data-name" "participation-count" ]
        [ div [ class Styles.label ]
            [ text (Translations.participants language) ]
        , div [ class Styles.value ]
            [ text (String.fromInt participantCount) ]
        ]


submittedResponseCount : Language -> Int -> Html msg
submittedResponseCount language responseCount =
    div [ attribute "data-name" "submitted-response-count" ]
        [ div [ class Styles.label ]
            [ text (Translations.responses language) ]
        , div [ class Styles.value ]
            [ text (String.fromInt responseCount) ]
        ]


submittedResponseRate : Language -> Float -> Html msg
submittedResponseRate language responseRate =
    div [ attribute "data-name" "submitted-response-rate" ]
        [ div [ class Styles.label ]
            [ text (Translations.responseRate language) ]
        , div [ class Styles.value ]
            [ text (Utils.percentFromFloat responseRate) ]
        ]
