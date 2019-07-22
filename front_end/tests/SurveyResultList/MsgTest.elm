module SurveyResultList.MsgTest exposing (all)

import Expect
import SurveyResultList.Data as Data
import SurveyResultList.Msg as Msg
import Test exposing (Test, describe, test)


all : Test
all =
    describe "Msg.fetched data"
        [ let
            data =
                Data.init

            expectedData =
                Msg.Fetched data

            actualData =
                Msg.fetched data
          in
          test "returns Msg.Fetched data" <|
            \() ->
                Expect.equal expectedData actualData
        ]
