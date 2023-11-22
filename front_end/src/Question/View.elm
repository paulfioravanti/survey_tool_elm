module Question.View exposing (view)

import Html.Styled exposing (Html, div, h3, span, text)
import Html.Styled.Attributes exposing (attribute, class, css)
import Language exposing (Language)
import Question.Aggregation as Aggregation
import Question.Model exposing (Question)
import Question.Styles as Styles
import SurveyResponse exposing (RespondentHistogram)
import Translations


view : Language -> Question -> Html msg
view language question =
    div
        [ attribute "data-name" "question"
        , class Styles.question
        ]
        [ descriptionText question
        , div [ class Styles.scores ]
            [ averageScore language question
            , responses language question
            ]
        ]



-- PRIVATE


descriptionText : Question -> Html msg
descriptionText question =
    h3
        [ attribute "data-name" "question-description"
        , class Styles.descriptionText
        ]
        [ text question.description ]


averageScore : Language -> Question -> Html msg
averageScore language question =
    h3
        [ attribute "data-name" "question-average-score"
        , class Styles.averageScore
        ]
        [ span
            [ class Styles.averageScoreLabel
            , css [ Styles.overlineText ]
            ]
            [ text (Translations.averageSymbol language) ]
        , text (Aggregation.averageScore question)
        ]


responses : Language -> Question -> Html msg
responses language question =
    let
        respondents : RespondentHistogram
        respondents =
            SurveyResponse.respondentHistogram question.surveyResponses
    in
    div
        [ attribute "data-name" "survey-responses"
        , class Styles.responses
        ]
        (List.map
            (SurveyResponse.view language respondents)
            SurveyResponse.ratings
        )
