module SurveyResult.Parser.IdTest exposing (all)

import Expect
import Fuzz exposing (Fuzzer)
import SurveyResult exposing (SurveyResult)
import SurveyResult.Fuzzer as SurveyResult
import SurveyResult.Parser as Parser
import Test exposing (Test, describe, fuzz, fuzz2)


all : Test
all =
    let
        randomSurveyResult : Fuzzer SurveyResult
        randomSurveyResult =
            SurveyResult.fuzzer
    in
    describe "SurveyResult.Parser.id"
        [ idWithSurveyResultWithNumberPlusFileExtensionTest
            randomSurveyResult
        , idWithSurveyResultWithNumberWithoutFileExtensionTest
            randomSurveyResult
        , idWithSurveyResultWithStringPlusFileExtensionTest
            randomSurveyResult
        , idWithSurveyResultWithStringWithoutFileExtensionTest
            randomSurveyResult
        , idWithSurveyResultWithInvalidUrlTest
            randomSurveyResult
        ]


idWithSurveyResultWithNumberPlusFileExtensionTest : Fuzzer SurveyResult -> Test
idWithSurveyResultWithNumberPlusFileExtensionTest randomSurveyResult =
    let
        randomId : Fuzzer Int
        randomId =
            Fuzz.int
    in
    describe
        """
        when given a survey result with a number plus file extension in its url
        """
        [ fuzz2 randomId randomSurveyResult "returns the number as a string" <|
            \intId surveyResult ->
                let
                    expectedId : String
                    expectedId =
                        String.fromInt intId

                    surveyResultWithNumberPlusFileExtensionInUrl : SurveyResult
                    surveyResultWithNumberPlusFileExtensionInUrl =
                        { surveyResult
                            | url = "/survey_results/" ++ expectedId ++ ".json"
                        }

                    actualId : String
                    actualId =
                        Parser.id surveyResultWithNumberPlusFileExtensionInUrl
                in
                Expect.equal expectedId actualId
        ]


idWithSurveyResultWithNumberWithoutFileExtensionTest :
    Fuzzer SurveyResult
    -> Test
idWithSurveyResultWithNumberWithoutFileExtensionTest randomSurveyResult =
    let
        randomId : Fuzzer Int
        randomId =
            Fuzz.int
    in
    describe
        """
        when given a survey result with a number without file
        extension in its url
        """
        [ fuzz2 randomId randomSurveyResult "returns the number as a string" <|
            \intId surveyResult ->
                let
                    expectedId : String
                    expectedId =
                        String.fromInt intId

                    surveyResultWithNumberWithoutFileExtensionInUrl : SurveyResult
                    surveyResultWithNumberWithoutFileExtensionInUrl =
                        { surveyResult
                            | url = "/survey_results/" ++ expectedId
                        }

                    actualId : String
                    actualId =
                        Parser.id
                            surveyResultWithNumberWithoutFileExtensionInUrl
                in
                Expect.equal expectedId actualId
        ]


idWithSurveyResultWithStringPlusFileExtensionTest : Fuzzer SurveyResult -> Test
idWithSurveyResultWithStringPlusFileExtensionTest randomSurveyResult =
    let
        expectedId : String
        expectedId =
            "abc"
    in
    describe
        """
        when given a survey result with a string plus file extension in its url
        """
        [ fuzz randomSurveyResult "returns the string" <|
            \surveyResult ->
                let
                    surveyResultWithStringPlusFileExtensionInUrl : SurveyResult
                    surveyResultWithStringPlusFileExtensionInUrl =
                        { surveyResult
                            | url = "/survey_results/" ++ expectedId ++ ".json"
                        }

                    actualId : String
                    actualId =
                        Parser.id surveyResultWithStringPlusFileExtensionInUrl
                in
                Expect.equal expectedId actualId
        ]


idWithSurveyResultWithStringWithoutFileExtensionTest :
    Fuzzer SurveyResult
    -> Test
idWithSurveyResultWithStringWithoutFileExtensionTest randomSurveyResult =
    let
        expectedId : String
        expectedId =
            "abc"
    in
    describe
        """
        when given a survey result with a string, without file
        extension in its url
        """
        [ fuzz randomSurveyResult "returns the string" <|
            \surveyResult ->
                let
                    surveyResultWithStringWithoutFileExtensionInUrl : SurveyResult
                    surveyResultWithStringWithoutFileExtensionInUrl =
                        { surveyResult
                            | url = "/survey_results/" ++ expectedId
                        }

                    actualId : String
                    actualId =
                        Parser.id
                            surveyResultWithStringWithoutFileExtensionInUrl
                in
                Expect.equal expectedId actualId
        ]


idWithSurveyResultWithInvalidUrlTest : Fuzzer SurveyResult -> Test
idWithSurveyResultWithInvalidUrlTest randomSurveyResult =
    let
        expectedId : String
        expectedId =
            ""
    in
    describe "when given a survey result with an invalid url"
        [ fuzz randomSurveyResult "returns an empty string" <|
            \surveyResult ->
                let
                    surveyResultWithInvalidUrl : SurveyResult
                    surveyResultWithInvalidUrl =
                        { surveyResult | url = "invalid" }

                    actualId : String
                    actualId =
                        Parser.id surveyResultWithInvalidUrl
                in
                Expect.equal expectedId actualId
        ]
