module Question.Aggregation exposing (averageScore, sumValidResponses)

{-| Aggregate functions for calculating statistics from Questions.
-}

import Question.Model exposing (Question)
import Round
import SurveyResponse exposing (SurveyResponse)


{-| Tallies the `responseContent` rating values from a `Question`, and returns
an average score, rounded to two decimal places.

Only valid `responseContent` values between values 1-5 are counted in the tally.

    import Question.Model exposing (Question)
    import SurveyResponse.Model exposing (SurveyResponse)

    questionWithValidResponses : Question
    questionWithValidResponses =
        Question
            "Do you agree that arrays start at 1?"
            [ SurveyResponse 1 1 1 "5"
            , SurveyResponse 2 1 2 "4"
            , SurveyResponse 3 1 3 "4"
            , SurveyResponse 4 1 4 "2"
            , SurveyResponse 5 1 5 "1"
            ]
            "ratingQuestion"

    averageScore questionWithValidResponses
    --> "3.20"

    questionWithSomeInvalidResponses : Question
    questionWithSomeInvalidResponses =
        Question
            "Do you agree that arrays start at 1?"
            [ SurveyResponse 1 1 1 "5"
            , SurveyResponse 2 1 2 "-1"
            , SurveyResponse 3 1 3 "0"
            , SurveyResponse 4 1 4 ""
            , SurveyResponse 5 1 5 "6"
            , SurveyResponse 5 1 5 "invalid"
            ]
            "ratingQuestion"

    averageScore questionWithSomeInvalidResponses
    --> "5.00"

-}
averageScore : Question -> String
averageScore question =
    let
        sumScores : Float
        sumScores =
            question
                |> sumValidResponses
                |> toFloat

        numScores : Float
        numScores =
            question
                |> countValidResponses
                |> toFloat
    in
    Round.round 2 (sumScores / numScores)


{-| Sums the `responseContent` rating values from a `Question`.

Only valid `responseContent` values between values 1-5 are included in the sum.

    import Question.Model exposing (Question)
    import SurveyResponse.Model exposing (SurveyResponse)

    questionWithValidResponses : Question
    questionWithValidResponses =
        Question
            "Do you agree that arrays start at 1?"
            [ SurveyResponse 1 1 1 "5"
            , SurveyResponse 2 1 2 "4"
            , SurveyResponse 3 1 3 "4"
            , SurveyResponse 4 1 4 "2"
            , SurveyResponse 5 1 5 "1"
            ]
            "ratingQuestion"

    sumValidResponses questionWithValidResponses
    --> 16

    questionWithSomeInvalidResponses : Question
    questionWithSomeInvalidResponses =
        Question
            "Do you agree that arrays start at 1?"
            [ SurveyResponse 1 1 1 "5"
            , SurveyResponse 2 1 2 "-1"
            , SurveyResponse 3 1 3 "0"
            , SurveyResponse 4 1 4 ""
            , SurveyResponse 5 1 5 "6"
            , SurveyResponse 5 1 5 "invalid"
            ]
            "ratingQuestion"

    sumValidResponses questionWithSomeInvalidResponses
    --> 5

-}
sumValidResponses : Question -> Int
sumValidResponses { surveyResponses } =
    let
        addResponseContent : SurveyResponse -> Int -> Int
        addResponseContent surveyResponse acc =
            acc + SurveyResponse.ratingScore surveyResponse
    in
    List.foldl addResponseContent 0 surveyResponses



-- PRIVATE


countValidResponses : Question -> Int
countValidResponses { surveyResponses } =
    List.foldl SurveyResponse.countValidResponse 0 surveyResponses
