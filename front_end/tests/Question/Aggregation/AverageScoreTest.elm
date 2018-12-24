module Question.Aggregation.AverageScoreTest exposing (all)

import Expect
import Fuzz exposing (Fuzzer)
import Question exposing (Question)
import Question.Aggregation
import Question.Fuzzer as Question
import SurveyResponse.Factory as Factory
import Test exposing (Test, describe, fuzz)


all : Test
all =
    let
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
        expectedScore =
            "3.20"
    in
    describe "when survey responses in Question all have valid response values"
        [ fuzz
            randomQuestion
            "returns an average of all survey response values"
            (\question ->
                let
                    questionWithValidSurveyResponses =
                        { question
                            | surveyResponses =
                                Factory.listOfValidSurveyResponses
                        }

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
        expectedScore =
            "5.00"
    in
    describe "when survey responses in Question have some invalid values"
        [ fuzz
            randomQuestion
            "returns the average of only valid survey response values"
            (\question ->
                let
                    questionWithSomeInvalidSurveyResponses =
                        { question
                            | surveyResponses =
                                Factory.listOfSomeInvalidSurveyResponses
                        }

                    actualScore =
                        Question.Aggregation.averageScore
                            questionWithSomeInvalidSurveyResponses
                in
                Expect.equal expectedScore actualScore
            )
        ]
