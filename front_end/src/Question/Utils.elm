module Question.Utils exposing (averageScore)

{-| Utility functions for Questions.
-}

import Question.Model exposing (Question)
import SurveyResponse
import Round


{-| Tallies the `responseContent` values from the `SurveyResponse`s in a list
of `Question`s and returns an average score, rounded to two decimal places.

Only valid `responseContent` values between values 1-5 are counted in the tally.

    import Question.Model exposing (Question)
    import SurveyResponse.Model exposing (SurveyResponse)

    validQuestions : List Question
    validQuestions =
        [ Question
              "Arrays start at 1"
              [ SurveyResponse 1 1 1 "5"
              , SurveyResponse 2 1 2 "4"
              , SurveyResponse 3 1 3 "4"
              , SurveyResponse 4 1 4 "2"
              , SurveyResponse 5 1 5 "1"
              ]
              "ratingQuestion"
        , Question
              "I can quit Vim"
              [ SurveyResponse 6 2 1 "3"
              , SurveyResponse 7 2 2 "4"
              , SurveyResponse 8 2 3 "5"
              , SurveyResponse 9 2 4 "1"
              , SurveyResponse 10 2 5 "1"
              ]
              "ratingQuestion"
        ]

    averageScore validQuestions
    --> "3.00"

    someInvalidQuestions : List Question
    someInvalidQuestions =
        [ Question
              "Arrays start at 1"
              [ SurveyResponse 1 1 1 "5"
              , SurveyResponse 2 1 2 "-1"
              , SurveyResponse 3 1 3 "4"
              , SurveyResponse 4 1 4 ""
              , SurveyResponse 5 1 5 "1"
              ]
              "ratingQuestion"
        , Question
              "I can quit Vim"
              [ SurveyResponse 6 2 1 "0"
              , SurveyResponse 7 2 2 "1"
              , SurveyResponse 8 2 3 "6"
              , SurveyResponse 9 2 4 "1"
              , SurveyResponse 10 2 5 "invalid"
              ]
              "ratingQuestion"
        ]

    averageScore someInvalidQuestions
    --> "2.40"
-}
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
                    |> List.foldl SurveyResponse.addValidResponse 0
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
                    |> SurveyResponse.sumResponseContent
                    |> (+) acc
            )
    in
        questions
            |> List.foldl addQuestionsSum 0
