module SurveyResult.MsgTest exposing (all)

import Expect
import SurveyResult.Data as Data
import SurveyResult.Msg as Msg
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
