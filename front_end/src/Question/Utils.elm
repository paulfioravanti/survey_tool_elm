module Question.Utils exposing (averageScore)

import Question.Model exposing (Question)
import SurveyResponse.Utils
import Round


averageScore : List Question -> String
averageScore questions =
    let
        sum =
            questions
                |> sumResponseContent
                |> toFloat

        total =
            questions
                |> countValidResponses
                |> toFloat
    in
        total
            |> (/) sum
            |> Round.round 2


countValidResponses : List Question -> Int
countValidResponses questions =
    let
        addQuestionSurveyResponsesCount =
            (\question acc ->
                question.surveyResponses
                    |> List.foldl SurveyResponse.Utils.addValidResponse 0
                    |> (+) acc
            )
    in
        questions
            |> List.foldl addQuestionSurveyResponsesCount 0


sumResponseContent : List Question -> Int
sumResponseContent questions =
    let
        addQuestionsSum =
            (\question acc ->
                question.surveyResponses
                    |> SurveyResponse.Utils.sumResponseContent
                    |> (+) acc
            )
    in
        questions
            |> List.foldl addQuestionsSum 0
