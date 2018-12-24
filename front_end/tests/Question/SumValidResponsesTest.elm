module Question.SumValidResponsesTest exposing (all)

import Expect
import Fuzz exposing (Fuzzer)
import Question exposing (Question)
import Question.Fuzzer as Question
import SurveyResponse.Factory as Factory
import SurveyResponse.Fuzzer as SurveyResponse
import Test exposing (Test, describe, fuzz, test)


all : Test
all =
    let
        randomQuestion =
            Question.fuzzer
    in
    describe "Question.sumValidResponses"
        [ ratingQuestionWithValidResponsesTest randomQuestion
        , ratingQuestionWithSomeInvalidResponsesTest randomQuestion
        ]


ratingQuestionWithValidResponsesTest : Fuzzer Question -> Test
ratingQuestionWithValidResponsesTest randomQuestion =
    let
        validSurveyResponses =
            Factory.listOfValidSurveyResponses

        expectedScore =
            16
    in
    describe "when survey responses in Question all have valid response values"
        [ fuzz
            randomQuestion
            "returns a sum reflecting all survey response value"
            (\question ->
                let
                    questionWithValidSurveyResponses =
                        { question | surveyResponses = validSurveyResponses }

                    actualScore =
                        Question.sumValidResponses
                            questionWithValidSurveyResponses
                in
                Expect.equal expectedScore actualScore
            )
        ]


ratingQuestionWithSomeInvalidResponsesTest : Fuzzer Question -> Test
ratingQuestionWithSomeInvalidResponsesTest randomQuestion =
    let
        invalidSurveyResponses =
            Factory.listOfSomeInvalidSurveyResponses

        expectedScore =
            5
    in
    describe "when survey responses in Question have some invalid values"
        [ fuzz
            randomQuestion
            "returns a sum reflecting only valid survey response values"
            (\question ->
                let
                    questionWithSomeInvalidSurveyResponses =
                        { question | surveyResponses = invalidSurveyResponses }

                    actualScore =
                        Question.sumValidResponses
                            questionWithSomeInvalidSurveyResponses
                in
                Expect.equal expectedScore actualScore
            )
        ]
