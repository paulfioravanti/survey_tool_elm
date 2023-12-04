module SurveyResultList.MsgTest exposing (all)

import Expect
import RemoteData exposing (WebData)
import SurveyResultList exposing (SurveyResultList)
import SurveyResultList.Data as Data
import SurveyResultList.Msg as Msg exposing (Msg)
import Test exposing (Test, describe, test)


all : Test
all =
    describe "Msg.fetched data"
        [ let
            data : WebData SurveyResultList
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
