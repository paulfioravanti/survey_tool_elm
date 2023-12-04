module SurveyResult.InitTest exposing (all)

import Expect
import Http exposing (Error)
import RemoteData exposing (RemoteData)
import SurveyResult exposing (SurveyResult)
import Test exposing (Test, describe, test)


all : Test
all =
    describe "SurveyResult.init"
        [ initTest
        ]


initTest : Test
initTest =
    let
        expectedData : RemoteData Error SurveyResult
        expectedData =
            RemoteData.NotAsked

        actualData : RemoteData Error SurveyResult
        actualData =
            SurveyResult.init
    in
    test "returns RemoteData.NotAsked" <|
        \() ->
            Expect.equal expectedData actualData
