module Theme.Aggregation exposing (averageScore)

import Question
import Round
import SurveyResponse
import Theme.Model exposing (Theme)


{-| Tallies the `responseContent` rating values from the `SurveyResponse`s in a
`Theme`'s list of `Question`s, and returns an average score, rounded to two
decimal places.

Only valid `responseContent` values between values 1-5 are counted in the tally.

    import Theme.Model exposing (Theme)
    import Question.Model exposing (Question)
    import SurveyResponse.Model exposing (SurveyResponse)

    themeWithValidQuestions : Theme
    themeWithValidQuestions =
        Theme
            "Computers"
            [ Question
                  "Arrays start at 1"
                  [ SurveyResponse 1 1 1 "5"
                  , SurveyResponse 2 1 2 "4"
                  , SurveyResponse 3 1 3 "4"
                  , SurveyResponse 4 1 4 "2"
                  , SurveyResponse 5 1 5 "1"
                  ]
                  "ratingquestion"
            , Question
                  "I can quit Vim"
                  [ SurveyResponse 6 2 1 "3"
                  , SurveyResponse 7 2 2 "4"
                  , SurveyResponse 8 2 3 "5"
                  , SurveyResponse 9 2 4 "1"
                  , SurveyResponse 10 2 5 "1"
                  ]
                  "ratingquestion"
            ]

    averageScore themeWithValidQuestions
    --> "3.00"

    themeWithSomeInvalidQuestions : Theme
    themeWithSomeInvalidQuestions =
        Theme
            "Computers"
            [ Question
                  "Arrays start at 1"
                  [ SurveyResponse 1 1 1 "5"
                  , SurveyResponse 2 1 2 "-1"
                  , SurveyResponse 3 1 3 "4"
                  , SurveyResponse 4 1 4 ""
                  , SurveyResponse 5 1 5 "1"
                  ]
                  "ratingquestion"
            , Question
                  "I can quit Vim"
                  [ SurveyResponse 6 2 1 "0"
                  , SurveyResponse 7 2 2 "1"
                  , SurveyResponse 8 2 3 "6"
                  , SurveyResponse 9 2 4 "1"
                  , SurveyResponse 10 2 5 "invalid"
                  ]
                  "ratingquestion"
            ]

    averageScore themeWithSomeInvalidQuestions
    --> "2.40"

-}
averageScore : Theme -> String
averageScore theme =
    let
        sumScores =
            theme
                |> sumValidResponses
                |> toFloat

        numScores =
            theme
                |> countValidResponses
                |> toFloat
    in
    sumScores
        / numScores
        |> Round.round 2



-- PRIVATE


countValidResponses : Theme -> Int
countValidResponses { questions } =
    let
        addQuestionSurveyResponsesCount question acc =
            question.surveyResponses
                |> List.foldl SurveyResponse.countValidResponse 0
                |> (+) acc
    in
    questions
        |> List.foldl addQuestionSurveyResponsesCount 0


sumValidResponses : Theme -> Int
sumValidResponses { questions } =
    let
        addQuestionSum question acc =
            question
                |> Question.sumValidResponses
                |> (+) acc
    in
    questions
        |> List.foldl addQuestionSum 0
