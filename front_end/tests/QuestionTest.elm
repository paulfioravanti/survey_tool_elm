module QuestionTest exposing (suite)

import Expect
import Question
import Question.Model exposing (Question)
import SurveyResponse.Model exposing (SurveyResponse)
import Test exposing (Test, describe, test)


suite : Test
suite =
    describe "Question"
        [ averageScoreTests () ]


averageScoreTests : () -> Test
averageScoreTests () =
    describe "averageScore"
        [ describe
            """
            when Question list contains valid responseContent values in the
            SurveyResponses of each individual Question.
            """
            [ test "sums all the values and rounds to two decimal points" <|
                \() ->
                    let
                        questions =
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
                    in
                        Question.averageScore questions
                            |> Expect.equal "3.00"
            ]
        , describe
            "when SurveyResponse list contains invalid responseContent values"
            [ test "sums all valid values and ignores invalid values" <|
                \() ->
                    let
                        questions =
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
                    in
                        Question.averageScore questions
                            |> Expect.equal "2.40"
            ]
        ]
