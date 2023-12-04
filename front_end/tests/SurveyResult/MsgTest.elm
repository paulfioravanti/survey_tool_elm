module SurveyResult.MsgTest exposing (all)

import Expect
import RemoteData exposing (WebData)
import SurveyResult exposing (SurveyResult)
import SurveyResult.Data as Data
import SurveyResult.Msg as Msg exposing (Msg)
import Test exposing (Test, describe, test)


all : Test
all =
    describe "Msg.fetched data"
        [ let
            data : WebData SurveyResult
            data =
                Data.init

            expectedData : Msg
            expectedData =
                Msg.Fetched data

            actualData : Msg
            actualData =
                Msg.fetched data
          in
          test "returns Msg.Fetched data" <|
            \() ->
                Expect.equal expectedData actualData
        ]
