module Message.LoadingTest exposing (suite)

import Expect
import Fuzzer.Config as Config
import Html.Attributes as Attributes
import Html.Styled
import Model exposing (Model)
import RemoteData exposing (RemoteData(NotRequested, Requesting))
import Router
import Routing.Route exposing (Route(ListSurveyResultsRoute))
import Test exposing (Test, describe, fuzz)
import Test.Html.Query as Query
import Test.Html.Selector exposing (attribute, tag)


suite : Test
suite =
    let
        config =
            Config.fuzzer
    in
        describe "view"
            [ fuzz
                config
                "displays a loading message when data has been requested"
              <|
                \config ->
                    let
                        model =
                            Model
                                config
                                ListSurveyResultsRoute
                                NotRequested
                                Requesting

                        loadingMessage =
                            attribute
                                (Attributes.attribute
                                    "data-name"
                                    "loading-message"
                                )
                    in
                        model
                            |> Router.route
                            |> Html.Styled.toUnstyled
                            |> Query.fromHtml
                            |> Query.find [ tag "section" ]
                            |> Query.has [ loadingMessage ]
            ]
