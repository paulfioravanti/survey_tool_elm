module Model.InitTest exposing (all)

import Expect
import Flags.Factory as Factory
import Model
import RemoteData
import Test exposing (Test, describe, test)
import Url.Factory as Factory


all : Test
all =
    describe "Model.init"
        [ initTest ]


initTest : Test
initTest =
    let
        flags =
            Factory.emptyFlags

        url =
            Factory.urlWithPath "/"

        key =
            Nothing
    in
    test "initialises the model" <|
        \() ->
            let
                model =
                    Model.init flags url key
            in
            ((model.surveyResultList == RemoteData.NotAsked)
                && (model.surveyResultDetail == RemoteData.NotAsked)
                && (model.title == "")
            )
                |> Expect.equal True
                |> Expect.onFail
                    """
                    Expected model surveyResultList and surveyResultDetail
                    to be NotAsked, and title to be blank
                    """
