module Question.Aggregation.AverageScoreTest exposing (all)

import Expect
import Factory.SurveyResponse as Factory
import Fuzz exposing (Fuzzer)
import Fuzzer.Question as Question
import Question exposing (Question)
import Question.Aggregation
import Test exposing (Test, describe, fuzz)


all : Test
all =
    let
        randomQuestion : Fuzzer Question
        randomQuestion =
            Question.fuzzer
    in
    describe "Question.Aggregation.averageScore"
        [ ratingQuestionWithValidResponsesTest randomQuestion
        , ratingQuestionWithSomeInvalidResponsesTest randomQuestion
        ]


ratingQuestionWithValidResponsesTest : Fuzzer Question -> Test
ratingQuestionWithValidResponsesTest randomQuestion =
    let
        expectedScore : String
        expectedScore =
            "3.20"
    in
    describe "when survey responses in Question all have valid response values"
        [ fuzz
            randomQuestion
            "returns an average of all survey response values"
            (\question ->
                let
                    questionWithValidSurveyResponses : Question
                    questionWithValidSurveyResponses =
                        { question
                            | surveyResponses =
                                Factory.listOfValidSurveyResponses
                        }

                    actualScore : String
                    actualScore =
                        Question.Aggregation.averageScore
                            questionWithValidSurveyResponses
                in
                Expect.equal expectedScore actualScore
            )
        ]


ratingQuestionWithSomeInvalidResponsesTest : Fuzzer Question -> Test
ratingQuestionWithSomeInvalidResponsesTest randomQuestion =
    let
        expectedScore : String
        expectedScore =
            "5.00"
    in
    describe "when survey responses in Question have some invalid values"
        [ fuzz
            randomQuestion
            "returns the average of only valid survey response values"
            (\question ->
                let
                    questionWithSomeInvalidSurveyResponses : Question
                    questionWithSomeInvalidSurveyResponses =
                        { question
                            | surveyResponses =
                                Factory.listOfSomeInvalidSurveyResponses
                        }

                    actualScore : String
                    actualScore =
                        Question.Aggregation.averageScore
                            questionWithSomeInvalidSurveyResponses
                in
                Expect.equal expectedScore actualScore
            )
        ]
