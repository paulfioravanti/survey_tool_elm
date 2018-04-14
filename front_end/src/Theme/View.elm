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
            , "mh1 mh0-ns"
            ]
                |> String.join " "
    in
        div [ attribute "data-name" "theme" ]
            [ div [ class classes ]
                [ themeName name
                , averageScore questions
                ]
            , div [ attribute "data-name" "questions" ]
                (List.map Question.View.view questions)
            ]


themeName : String -> Html msg
themeName name =
    let
        classes =
            [ "dark-gray"
            , "f4 f3-ns"
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
            , "f4 f3-ns"
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
                [ text "Average Score" ]
            , text (Question.Utils.averageScore questions)
            ]
