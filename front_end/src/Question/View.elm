module Question.View exposing (view)

import Html.Styled exposing (Html, div, h3, span, text)
import Html.Styled.Attributes exposing (attribute, class, css)
import Question.Model exposing (Question)
import Styles
import SurveyResponse.Model exposing (SurveyResponse)
import SurveyResponse.Utils
import SurveyResponse.View


view : Question -> Html msg
view { description, surveyResponses } =
    let
        classes =
            [ "flex"
            , "flex-row"
            , "justify-between"
            , "mv2"
            ]
                |> String.join " "
    in
        div [ attribute "data-name" "question" ]
            [ div [ class classes ]
                [ descriptionText description
                , div []
                    [ averageScore surveyResponses
                    , responses surveyResponses
                    ]
                ]
            ]


descriptionText : String -> Html msg
descriptionText description =
    let
        classes =
            [ "fw4"
            , "w-70"
            ]
                |> String.join " "
    in
        h3 [ attribute "data-name" "question-description", class classes ]
            [ text description ]


averageScore : List SurveyResponse -> Html msg
averageScore surveyResponses =
    let
        averageScore =
            surveyResponses
                |> SurveyResponse.Utils.averageScore

        classes =
            [ "tr"
            ]
                |> String.join " "

        labelClasses =
            [ "fw1"
            , "i"
            , "mr2"
            , "times"
            ]
                |> String.join " "
    in
        h3 [ attribute "data-name" "question-average-score", class classes ]
            [ span [ class labelClasses, css [ Styles.overlineText ] ]
                [ text "x" ]
            , text averageScore
            ]


responses : List SurveyResponse -> Html msg
responses surveyResponses =
    let
        ratings =
            [ "1", "2", "3", "4", "5" ]

        respondents =
            surveyResponses
                |> SurveyResponse.Utils.respondentHistogram

        classes =
            [ "flex"
            , "flex-row"
            ]
                |> String.join " "
    in
        div [ attribute "data-name" "survey-responses", class classes ]
            (List.map (SurveyResponse.View.view respondents) ratings)
