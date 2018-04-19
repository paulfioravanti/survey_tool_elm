module Question.View exposing (view)

import Html.Styled exposing (Html, div, h3, span, text)
import Html.Styled.Attributes exposing (attribute, class, css)
import I18Next exposing (Translations)
import Styles
import SurveyResponse exposing (RespondentHistogram, SurveyResponse)


view : Translations -> String -> List SurveyResponse -> Html msg
view translations description surveyResponses =
    let
        classes =
            [ "flex"
            , "flex-column flex-row-ns"
            , "justify-between-ns"
            , "mh1 mh0-ns"
            , "mv2"
            ]
                |> String.join " "

        scoresClasses =
            [ "flex"
            , "flex-row-reverse flex-column-ns"
            , "justify-between-ns"
            ]
                |> String.join " "
    in
        div [ attribute "data-name" "question" ]
            [ div [ class classes ]
                [ descriptionText description
                , div [ class scoresClasses ]
                    [ averageScore
                        (I18Next.t translations "averageSymbol")
                        surveyResponses
                    , responses translations surveyResponses
                    ]
                ]
            ]


descriptionText : String -> Html msg
descriptionText description =
    let
        classes =
            [ "fw4"
            , "w-70-ns"
            ]
                |> String.join " "
    in
        h3 [ attribute "data-name" "question-description", class classes ]
            [ text description ]


averageScore : String -> List SurveyResponse -> Html msg
averageScore label surveyResponses =
    let
        averageScore =
            surveyResponses
                |> SurveyResponse.averageScore

        classes =
            [ "fw5"
            , "mt2 mt3-ns"
            , "tr"
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
                [ text label ]
            , text averageScore
            ]


responses : Translations -> List SurveyResponse -> Html msg
responses translations surveyResponses =
    let
        ratings =
            [ "1", "2", "3", "4", "5" ]

        respondents =
            surveyResponses
                |> SurveyResponse.respondentHistogram

        classes =
            [ "flex"
            , "flex-row"
            , "mr3 mr0-ns"
            ]
                |> String.join " "
    in
        div [ attribute "data-name" "survey-responses", class classes ]
            (List.map (SurveyResponse.view translations respondents) ratings)
