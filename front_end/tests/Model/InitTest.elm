module Model.InitTest exposing (all)

import Expect
import Flags exposing (Flags)
import Flags.Factory as Factory
import Model exposing (Model)
import RemoteData
import Test exposing (Test, describe, test)
import Url exposing (Url)
import Url.Factory as Factory


all : Test
all =
    describe "Model.init"
        [ initTest ]


initTest : Test
initTest =
    let
        flags : Flags
        flags =
            Factory.emptyFlags

        url : Url
        url =
            Factory.urlWithPath "/"

        key : Maybe a
        key =
            Nothing
    in
    test "initialises the model" <|
        \() ->
            let
                model : Model
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
