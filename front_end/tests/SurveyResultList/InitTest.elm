module SurveyResultList.InitTest exposing (all)

import Expect
import Fuzz
import RemoteData
import SurveyResultList
import Test exposing (Test, describe, test)


all : Test
all =
    describe "SurveyResultList.init"
        [ initTest
        ]


initTest : Test
initTest =
    let
        expectedData =
            RemoteData.NotAsked

        actualData =
            SurveyResultList.init
    in
    test "returns RemoteData.NotAsked" <|
        \() ->
            Expect.equal expectedData actualData
