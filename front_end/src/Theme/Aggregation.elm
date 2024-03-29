module Theme.Aggregation exposing (averageScore)

import Question exposing (Question)
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
        sumScores : Float
        sumScores =
            theme
                |> sumValidResponses
                |> toFloat

        numScores : Float
        numScores =
            theme
                |> countValidResponses
                |> toFloat
    in
    Round.round 2 (sumScores / numScores)



-- PRIVATE


countValidResponses : Theme -> Int
countValidResponses { questions } =
    let
        addQuestionSurveyResponsesCount : Question -> Int -> Int
        addQuestionSurveyResponsesCount question acc =
            let
                count : Int
                count =
                    List.foldl
                        SurveyResponse.countValidResponse
                        0
                        question.surveyResponses
            in
            acc + count
    in
    List.foldl addQuestionSurveyResponsesCount 0 questions


sumValidResponses : Theme -> Int
sumValidResponses { questions } =
    let
        addQuestionSum : Question -> Int -> Int
        addQuestionSum question acc =
            acc + Question.sumValidResponses question
    in
    List.foldl addQuestionSum 0 questions
