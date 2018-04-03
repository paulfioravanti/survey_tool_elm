module ViewTest exposing (viewTests)

import Expect
import Fuzzer.Config as Config
import Html.Attributes exposing (type_, value)
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


viewTests : Test
viewTests =
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
            , fuzz
                config
                "displays a loading page when data has been requested"
              <|
                \config ->
                    let
                        model =
                            Model Requesting config ListSurveyResultsRoute
                    in
                        model
                            |> View.view
                            |> Query.fromHtml
                            |> Query.find [ tag "h1" ]
                            |> Query.has [ text "Loading" ]
            ]
