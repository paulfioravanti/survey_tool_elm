module ViewTest exposing (suite)

import Expect
import Fuzzer.Config as Config
import Model exposing (Model)
import RemoteData exposing (RemoteData(NotRequested))
import Routing.Route exposing (Route(ListSurveyResultsRoute))
import Test exposing (Test, describe, fuzz)
import Test.Html.Query as Query
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
