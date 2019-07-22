module Msg.MsgTest exposing (all)

import Expect
import Msg
import SurveyResult
import SurveyResult.Msg
import SurveyResultList
import SurveyResultList.Msg
import Test exposing (Test, describe, fuzz, test)
import Url.Factory as Factory
import UrlRequest.Fuzzer as UrlRequest


all : Test
all =
    describe "Msg"
        [ surveyResultTest
        , surveyResultListTest
        , urlChangedTest
        , urlRequestedTest
        ]


surveyResultTest : Test
surveyResultTest =
    let
        surveyResultMsg =
            SurveyResult.Msg.Fetched SurveyResult.init

        expectedData =
            Msg.SurveyResult surveyResultMsg

        actualData =
            Msg.surveyResult surveyResultMsg
    in
    describe "Msg.surveyResult surveyResultMsg"
        [ test "returns Msg.SurveyResult surveyResultMsg" <|
            \() ->
                Expect.equal expectedData actualData
        ]


surveyResultListTest : Test
surveyResultListTest =
    let
        surveyResultListMsg =
            SurveyResultList.Msg.Fetched SurveyResultList.init

        expectedData =
            Msg.SurveyResultList surveyResultListMsg

        actualData =
            Msg.surveyResultList surveyResultListMsg
    in
    describe "Msg.surveyResultList surveyResultListMsg"
        [ test "returns Msg.SurveyResultList surveyResultListMsg" <|
            \() ->
                Expect.equal expectedData actualData
        ]


urlChangedTest : Test
urlChangedTest =
    let
        url =
            Factory.urlWithPath "/"

        expectedData =
            Msg.UrlChanged url

        actualData =
            Msg.urlChanged url
    in
    describe "Msg.urlChanged url"
        [ test "returns Msg.UrlChanged url" <|
            \() ->
                Expect.equal expectedData actualData
        ]


urlRequestedTest : Test
urlRequestedTest =
    let
        randomUrlRequest =
            UrlRequest.fuzzer
    in
    describe "Msg.urlRequested urlRequest"
        [ fuzz randomUrlRequest "returns Msg.UrlRequested urlRequest" <|
            \urlRequest ->
                let
                    expectedData =
                        Msg.UrlRequested urlRequest

                    actualData =
                        Msg.urlRequested urlRequest
                in
                Expect.equal expectedData actualData
        ]
