module Messages.NotFoundTest exposing (suite)

import Expect
import Fuzzer.Config as Config
import Html.Attributes as Attributes
import Model exposing (Model)
import RemoteData exposing (RemoteData(NotRequested))
import Routing.Route exposing (Route(NotFoundRoute))
import Test exposing (Test, describe, fuzz)
import Test.Html.Query as Query
import Test.Html.Selector as Selector exposing (tag)
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
                "displays an error message when page cannot be found"
              <|
                \config ->
                    let
                        model =
                            Model
                                NotRequested
                                config
                                NotFoundRoute

                        notFoundMessage =
                            Selector.attribute
                                (Attributes.attribute
                                    "data-name"
                                    "not-found-message"
                                )
                    in
                        model
                            |> View.view
                            |> Query.fromHtml
                            |> Query.find [ tag "section" ]
                            |> Query.has [ notFoundMessage ]
            ]
