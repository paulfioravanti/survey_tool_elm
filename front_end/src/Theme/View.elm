module Theme.View exposing (view)

import Html.Styled exposing (Html, div, h2, span, text)
import Html.Styled.Attributes exposing (attribute, class)
import Language exposing (Language)
import Question
import Theme.Aggregation as Aggregation
import Theme.Model exposing (Theme)
import Theme.Styles as Styles
import Translations


view : Language -> Theme -> Html msg
view language theme =
    div [ attribute "data-name" "theme" ]
        [ div [ class Styles.theme ]
            [ name theme
            , averageScore language theme
            ]
        , div [ attribute "data-name" "questions" ]
            (List.map (Question.view language) theme.questions)
        ]



-- PRIVATE


name : Theme -> Html msg
name theme =
    h2 [ class Styles.name ]
        [ text theme.name ]


averageScore : Language -> Theme -> Html msg
averageScore language theme =
    h2
        [ attribute "data-name" "theme-average-score"
        , class Styles.averageScore
        ]
        [ span [ class Styles.averageScoreLabel ]
            [ text (Translations.averageScore language) ]
        , span [ class Styles.averageScoreValue ]
            [ text (Aggregation.averageScore theme) ]
        ]
