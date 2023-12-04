module SurveyResultList.InitTest exposing (all)

import Expect
import Http exposing (Error)
import RemoteData exposing (RemoteData)
import SurveyResultList exposing (SurveyResultList)
import Test exposing (Test, describe, test)


all : Test
all =
    describe "SurveyResultList.init"
        [ initTest
        ]


initTest : Test
initTest =
    let
        expectedData : RemoteData Error SurveyResultList
        expectedData =
            RemoteData.NotAsked

        actualData : RemoteData Error SurveyResultList
        actualData =
            SurveyResultList.init
    in
    test "returns RemoteData.NotAsked" <|
        \() ->
            Expect.equal expectedData actualData
