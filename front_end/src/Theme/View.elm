module Theme.View exposing (view)

import Html.Styled exposing (Html, div, h2, span, text)
import Html.Styled.Attributes exposing (attribute, class)
import Question.Model exposing (Question)
import Question.Utils
import Question.View
import Theme.Model exposing (Theme)


view : Theme -> Html msg
view { name, questions } =
    let
        classes =
            [ "b--light-gray"
            , "bb"
            , "flex"
            , "flex-row"
            , "justify-between"
            , "mv2"
            ]
                |> String.join " "
    in
        div [ attribute "data-name" "theme" ]
            [ div [ class classes ]
                [ nameText name
                , averageScore questions
                ]
            , div [ attribute "data-name" "questions" ]
                (List.map Question.View.view questions)
            ]


nameText : String -> Html msg
nameText name =
    let
        classes =
            [ "dark-gray"
            , "f3"
            , "ttu"
            ]
                |> String.join " "
    in
        h2 [ class classes ]
            [ text name ]


averageScore : List Question -> Html msg
averageScore questions =
    let
        classes =
            [ "b"
            , "f3"
            ]
                |> String.join " "

        labelClasses =
            [ "fw2"
            , "mr2"
            ]
                |> String.join " "
    in
        h2 [ attribute "data-name" "theme-average-score", class classes ]
            [ span [ class labelClasses ]
                [ text "Average Score " ]
            , text (Question.Utils.averageScore questions)
            ]
