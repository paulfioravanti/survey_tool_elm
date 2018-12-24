module SurveyResponse.CountValidResponseTest exposing (all)

import Expect
import Fuzz exposing (Fuzzer)
import SurveyResponse exposing (SurveyResponse)
import SurveyResponse.Fuzzer as SurveyResponse
import Test exposing (Test, describe, fuzz2, fuzz3)


all : Test
all =
    let
        randomSurveyResponse =
            SurveyResponse.fuzzer

        randomAcc =
            Fuzz.int
    in
    describe "SurveyResponse.countValidResponse"
        [ countValidResponseWithEmptyResponseContentTest
            randomSurveyResponse
            randomAcc
        , countValidResponseWithValidResponseContentTest
            randomSurveyResponse
            randomAcc
        , countValidResponseWithOutOfRangeResponseContentTest
            randomSurveyResponse
            randomAcc
        , countValidResponseWithNonIntResponseContentTest
            randomSurveyResponse
            randomAcc
        ]


countValidResponseWithEmptyResponseContentTest :
    Fuzzer SurveyResponse
    -> Fuzzer Int
    -> Test
countValidResponseWithEmptyResponseContentTest randomSurveyResponse randomAcc =
    describe "when given a response with empty content"
        [ fuzz2
            randomSurveyResponse
            randomAcc
            "does not accumulate the acc value"
            (\surveyResponse acc ->
                let
                    expectedAccValue =
                        acc

                    emptySurveyResponse =
                        { surveyResponse | responseContent = "" }

                    actualAccValue =
                        SurveyResponse.countValidResponse
                            emptySurveyResponse
                            acc
                in
                Expect.equal expectedAccValue actualAccValue
            )
        ]


countValidResponseWithValidResponseContentTest :
    Fuzzer SurveyResponse
    -> Fuzzer Int
    -> Test
countValidResponseWithValidResponseContentTest randomSurveyResponse randomAcc =
    let
        randomValidScore =
            Fuzz.intRange 1 5
    in
    describe "when given a response with valid content"
        [ fuzz3
            randomSurveyResponse
            randomAcc
            randomValidScore
            "accumulates the acc value by 1"
            (\surveyResponse acc intScore ->
                let
                    expectedAccValue =
                        acc + 1

                    responseContent =
                        String.fromInt intScore

                    surveyResponseWithValidContent =
                        { surveyResponse | responseContent = responseContent }

                    actualAccValue =
                        SurveyResponse.countValidResponse
                            surveyResponseWithValidContent
                            acc
                in
                Expect.equal expectedAccValue actualAccValue
            )
        ]


countValidResponseWithOutOfRangeResponseContentTest :
    Fuzzer SurveyResponse
    -> Fuzzer Int
    -> Test
countValidResponseWithOutOfRangeResponseContentTest randomSurveyResponse randomAcc =
    let
        randomInvalidIntScore =
            Fuzz.oneOf
                [ Fuzz.intRange -1 0
                , Fuzz.intRange 6 7
                ]
    in
    describe "when given a response containing an out of range integer value"
        [ fuzz3
            randomSurveyResponse
            randomAcc
            randomInvalidIntScore
            "does not accumulate the acc value"
            (\surveyResponse acc intScore ->
                let
                    expectedAccValue =
                        acc

                    responseContent =
                        String.fromInt intScore

                    surveyResponseWithOutOfRangeIntValue =
                        { surveyResponse | responseContent = responseContent }

                    actualAccValue =
                        SurveyResponse.countValidResponse
                            surveyResponseWithOutOfRangeIntValue
                            acc
                in
                Expect.equal expectedAccValue actualAccValue
            )
        ]


countValidResponseWithNonIntResponseContentTest :
    Fuzzer SurveyResponse
    -> Fuzzer Int
    -> Test
countValidResponseWithNonIntResponseContentTest randomSurveyResponse randomAcc =
    describe "when given a response containing a non-integer string value"
        [ fuzz2
            randomSurveyResponse
            randomAcc
            "does not accumulate the acc value"
            (\surveyResponse acc ->
                let
                    expectedAccValue =
                        acc

                    surveyResponseWithNonIntStringValue =
                        { surveyResponse | responseContent = "invalid" }

                    actualAccValue =
                        SurveyResponse.countValidResponse
                            surveyResponseWithNonIntStringValue
                            acc
                in
                Expect.equal expectedAccValue actualAccValue
            )
        ]
