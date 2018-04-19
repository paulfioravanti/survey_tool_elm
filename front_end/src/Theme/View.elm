module Theme.View exposing (view)

{-| Display the contents of a theme.
-}

import Html.Styled exposing (Html, div, h2, span, text)
import Html.Styled.Attributes exposing (attribute, class)
import I18Next exposing (Translations)
import Question exposing (Question)
import Theme.Model exposing (Theme)


view : Translations -> Theme -> Html msg
view translations { name, questions } =
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
                , averageScore
                    (I18Next.t translations "averageScore")
                    questions
                ]
            , div [ attribute "data-name" "questions" ]
                (List.map (Question.view translations) questions)
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


averageScore : String -> List Question -> Html msg
averageScore label questions =
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
                [ text label ]
            , text (Question.averageScore questions)
            ]
