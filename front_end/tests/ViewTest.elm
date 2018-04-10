module ViewTest exposing (suite)

import Controller
import Expect
import Fuzzer.Config as Config
import Html exposing (Html, text)
import Html.Styled
import Model exposing (Model)
import RemoteData exposing (RemoteData(NotRequested))
import Routing.Route exposing (Route(ListSurveyResultsRoute))
import Test exposing (Test, describe, fuzz)
import Test.Html.Query as Query


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
                            Model
                                config
                                ListSurveyResultsRoute
                                NotRequested
                                NotRequested
                    in
                        model
                            |> Controller.render
                            |> Html.Styled.toUnstyled
                            |> Query.fromHtml
                            |> Query.children []
                            |> Query.count (Expect.equal 0)
            ]
