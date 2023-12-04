module SurveyResponse.RatingScoreTest exposing (all)

import Expect
import Fuzz exposing (Fuzzer)
import SurveyResponse exposing (SurveyResponse)
import SurveyResponse.Fuzzer as SurveyResponse
import Test exposing (Test, describe, fuzz, fuzz2)


all : Test
all =
    let
        randomSurveyResponse : Fuzzer SurveyResponse
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
                    expectedScore : Int
                    expectedScore =
                        0

                    emptySurveyResponse : SurveyResponse
                    emptySurveyResponse =
                        { surveyResponse | responseContent = "" }

                    actualScore : Int
                    actualScore =
                        SurveyResponse.ratingScore emptySurveyResponse
                in
                Expect.equal expectedScore actualScore
        ]


ratingScoreWithValidResponseContentTest : Fuzzer SurveyResponse -> Test
ratingScoreWithValidResponseContentTest randomSurveyResponse =
    let
        randomValidScore : Fuzzer Int
        randomValidScore =
            Fuzz.intRange 1 5
    in
    describe "when given a response with valid score in the content"
        [ fuzz2 randomSurveyResponse randomValidScore "returns the score" <|
            \surveyResponse score ->
                let
                    expectedScore : Int
                    expectedScore =
                        score

                    responseContent : String
                    responseContent =
                        String.fromInt score

                    surveyResponseWithValidScore : SurveyResponse
                    surveyResponseWithValidScore =
                        { surveyResponse | responseContent = responseContent }

                    actualScore : Int
                    actualScore =
                        SurveyResponse.ratingScore surveyResponseWithValidScore
                in
                Expect.equal expectedScore actualScore
        ]


ratingScoreWithOutOfRangeResponseContentTest : Fuzzer SurveyResponse -> Test
ratingScoreWithOutOfRangeResponseContentTest randomSurveyResponse =
    let
        randomInvalidIntScore : Fuzzer Int
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
                    expectedScore : Int
                    expectedScore =
                        0

                    responseContent : String
                    responseContent =
                        String.fromInt intScore

                    surveyResponseWithOutOfRangeIntValue : SurveyResponse
                    surveyResponseWithOutOfRangeIntValue =
                        { surveyResponse | responseContent = responseContent }

                    actualScore : Int
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
                    expectedScore : Int
                    expectedScore =
                        0

                    surveyResponseWithNonIntStringValue : SurveyResponse
                    surveyResponseWithNonIntStringValue =
                        { surveyResponse | responseContent = "invalid" }

                    actualScore : Int
                    actualScore =
                        SurveyResponse.ratingScore
                            surveyResponseWithNonIntStringValue
                in
                Expect.equal expectedScore actualScore
        ]
