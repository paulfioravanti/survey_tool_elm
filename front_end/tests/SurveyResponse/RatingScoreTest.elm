module SurveyResponse.RatingScoreTest exposing (all)

import Expect
import Fuzz exposing (Fuzzer)
import SurveyResponse exposing (SurveyResponse)
import SurveyResponse.Fuzzer as SurveyResponse
import Test exposing (Test, describe, fuzz, fuzz2, test)


all : Test
all =
    let
        randomSurveyResponse =
            SurveyResponse.fuzzer
    in
    describe "SurveyResponse.ratingScore"
        [ ratingScoreWithEmptyResponseContentTest randomSurveyResponse
        , ratingScoreWithValidResponseContentTest randomSurveyResponse
        , ratingScoreWithOutOfRangeResponseContentTest randomSurveyResponse
        , ratingScoreWithNonIntResponseContentTest randomSurveyResponse
        ]


ratingScoreWithEmptyResponseContentTest : Fuzzer SurveyResponse -> Test
ratingScoreWithEmptyResponseContentTest randomSurveyResponse =
    describe "when given a response with empty content"
        [ fuzz randomSurveyResponse "returns 0" <|
            \surveyResponse ->
                let
                    expectedScore =
                        0

                    emptySurveyResponse =
                        { surveyResponse | responseContent = "" }

                    actualScore =
                        SurveyResponse.ratingScore emptySurveyResponse
                in
                Expect.equal expectedScore actualScore
        ]


ratingScoreWithValidResponseContentTest : Fuzzer SurveyResponse -> Test
ratingScoreWithValidResponseContentTest randomSurveyResponse =
    let
        randomValidScore =
            Fuzz.intRange 1 5
    in
    describe "when given a response with valid score in the content"
        [ fuzz2 randomSurveyResponse randomValidScore "returns the score" <|
            \surveyResponse score ->
                let
                    expectedScore =
                        score

                    responseContent =
                        String.fromInt score

                    surveyResponseWithValidScore =
                        { surveyResponse | responseContent = responseContent }

                    actualScore =
                        SurveyResponse.ratingScore surveyResponseWithValidScore
                in
                Expect.equal expectedScore actualScore
        ]


ratingScoreWithOutOfRangeResponseContentTest : Fuzzer SurveyResponse -> Test
ratingScoreWithOutOfRangeResponseContentTest randomSurveyResponse =
    let
        randomInvalidIntScore =
            Fuzz.oneOf
                [ Fuzz.intRange -1 0
                , Fuzz.intRange 6 7
                ]
    in
    describe "when given a response containing an out of range integer value"
        [ fuzz2 randomSurveyResponse randomInvalidIntScore "returns 0" <|
            \surveyResponse intScore ->
                let
                    expectedScore =
                        0

                    responseContent =
                        String.fromInt intScore

                    surveyResponseWithOutOfRangeIntValue =
                        { surveyResponse | responseContent = responseContent }

                    actualScore =
                        SurveyResponse.ratingScore
                            surveyResponseWithOutOfRangeIntValue
                in
                Expect.equal expectedScore actualScore
        ]


ratingScoreWithNonIntResponseContentTest : Fuzzer SurveyResponse -> Test
ratingScoreWithNonIntResponseContentTest randomSurveyResponse =
    describe "when given a response containing a non-integer string value"
        [ fuzz randomSurveyResponse "returns 0" <|
            \surveyResponse ->
                let
                    expectedScore =
                        0

                    surveyResponseWithNonIntStringValue =
                        { surveyResponse | responseContent = "invalid" }

                    actualScore =
                        SurveyResponse.ratingScore
                            surveyResponseWithNonIntStringValue
                in
                Expect.equal expectedScore actualScore
        ]
