module Model.InitTest exposing (all)

import Expect
import Factory.Flags as Factory
import Factory.Url as Factory
import Flags exposing (Flags)
import Model exposing (Model)
import RemoteData
import Test exposing (Test, describe, test)
import Url exposing (Url)


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
