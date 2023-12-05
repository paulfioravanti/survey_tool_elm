module Theme.Aggregation.AverageScoreTest exposing (all)

import Expect
import Factory.Question as Factory
import Fuzz exposing (Fuzzer)
import Fuzzer.Theme as Theme
import Test exposing (Test, describe, fuzz)
import Theme exposing (Theme)
import Theme.Aggregation


all : Test
all =
    let
        randomTheme : Fuzzer Theme
        randomTheme =
            Theme.fuzzer
    in
    describe "Theme.Aggregation.averageScore"
        [ averageScoreWithThemeWithValidQuestionsTest randomTheme
        , averageScoreWithThemeWithSomeInvalidQuestionsTest randomTheme
        ]


averageScoreWithThemeWithValidQuestionsTest : Fuzzer Theme -> Test
averageScoreWithThemeWithValidQuestionsTest randomTheme =
    let
        expectedScore : String
        expectedScore =
            "3.00"
    in
    describe "when questions in Theme all have valid response values"
        [ fuzz
            randomTheme
            "returns an average of all question survey response values"
            (\theme ->
                let
                    themeWithValidQuestions : Theme
                    themeWithValidQuestions =
                        { theme | questions = Factory.listOfValidQuestions }

                    actualScore : String
                    actualScore =
                        Theme.Aggregation.averageScore themeWithValidQuestions
                in
                Expect.equal expectedScore actualScore
            )
        ]


averageScoreWithThemeWithSomeInvalidQuestionsTest : Fuzzer Theme -> Test
averageScoreWithThemeWithSomeInvalidQuestionsTest randomTheme =
    let
        expectedScore : String
        expectedScore =
            "2.40"
    in
    describe "when question survey responses in Theme have some invalid values"
        [ fuzz
            randomTheme
            "returns the average of only valid question survey response values"
            (\theme ->
                let
                    themeWithSomeInvalidQuestions : Theme
                    themeWithSomeInvalidQuestions =
                        { theme
                            | questions = Factory.listOfSomeInvalidQuestions
                        }

                    actualScore : String
                    actualScore =
                        Theme.Aggregation.averageScore
                            themeWithSomeInvalidQuestions
                in
                Expect.equal expectedScore actualScore
            )
        ]
