module ViewTest exposing (suite)

import Expect
import Fuzzer.Config as Config
import Html.Attributes as Attributes
import Http exposing (Error(NetworkError))
import Model exposing (Model)
import RemoteData
    exposing
        ( RemoteData
            ( Failure
            , NotRequested
            , Requesting
            , Success
            )
        )
import Routing.Route
    exposing
        ( Route
            ( ListSurveyResultsRoute
            , NotFoundRoute
            , SurveyResultDetailRoute
            )
        )
import Test exposing (Test, describe, fuzz)
import Test.Html.Query as Query
import Test.Html.Selector exposing (attribute, class, classes, id, tag, text)
import View


suite : Test
suite =
    let
        config =
            Config.fuzzer
    in
        describe "view"
            [ fuzz
                config
                "displays a blank page when no data has been requested"
              <|
                \config ->
                    let
                        model =
                            Model NotRequested config ListSurveyResultsRoute
                    in
                        model
                            |> View.view
                            |> Query.fromHtml
                            |> Query.contains []
            ]
