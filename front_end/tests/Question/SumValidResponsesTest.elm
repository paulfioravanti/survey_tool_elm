module Question.SumValidResponsesTest exposing (all)

import Expect
import Fuzz exposing (Fuzzer)
import Question exposing (Question)
import Question.Fuzzer as Question
import SurveyResponse exposing (SurveyResponse)
import SurveyResponse.Factory as Factory
import Test exposing (Test, describe, fuzz)


all : Test
all =
    let
        randomQuestion : Fuzzer Question
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
        validSurveyResponses : List SurveyResponse
        validSurveyResponses =
            Factory.listOfValidSurveyResponses

        expectedScore : Int
        expectedScore =
            16
    in
    describe "when survey responses in Question all have valid response values"
        [ fuzz
            randomQuestion
            "returns a sum reflecting all survey response value"
            (\question ->
                let
                    questionWithValidSurveyResponses : Question
                    questionWithValidSurveyResponses =
                        { question | surveyResponses = validSurveyResponses }

                    actualScore : Int
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
        invalidSurveyResponses : List SurveyResponse
        invalidSurveyResponses =
            Factory.listOfSomeInvalidSurveyResponses

        expectedScore : Int
        expectedScore =
            5
    in
    describe "when survey responses in Question have some invalid values"
        [ fuzz
            randomQuestion
            "returns a sum reflecting only valid survey response values"
            (\question ->
                let
                    questionWithSomeInvalidSurveyResponses : Question
                    questionWithSomeInvalidSurveyResponses =
                        { question | surveyResponses = invalidSurveyResponses }

                    actualScore : Int
                    actualScore =
                        Question.sumValidResponses
                            questionWithSomeInvalidSurveyResponses
                in
                Expect.equal expectedScore actualScore
            )
        ]
