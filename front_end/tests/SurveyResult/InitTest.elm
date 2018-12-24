module SurveyResult.InitTest exposing (all)

import Expect
import Fuzz
import RemoteData
import SurveyResult
import Test exposing (Test, describe, test)


all : Test
all =
    describe "SurveyResult.init"
        [ initTest
        ]


initTest : Test
initTest =
    let
        expectedData =
            RemoteData.NotAsked

        actualData =
            SurveyResult.init
    in
    test "returns RemoteData.NotAsked" <|
        \() ->
            Expect.equal expectedData actualData
