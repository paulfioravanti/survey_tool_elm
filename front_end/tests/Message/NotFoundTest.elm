module Message.NotFoundTest exposing (suite)

import Controller
import Expect
import Fuzzer.Config as Config
import Html.Attributes as Attributes
import Html.Styled
import Model exposing (Model)
import RemoteData exposing (RemoteData(NotRequested))
import Routing.Route exposing (Route(NotFoundRoute))
import Test exposing (Test, describe, fuzz)
import Test.Html.Query as Query
import Test.Html.Selector as Selector exposing (tag)


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
                                config
                                NotFoundRoute
                                NotRequested
                                NotRequested

                        notFoundMessage =
                            Selector.attribute
                                (Attributes.attribute
                                    "data-name"
                                    "not-found-message"
                                )
                    in
                        model
                            |> Controller.render
                            |> Html.Styled.toUnstyled
                            |> Query.fromHtml
                            |> Query.find [ tag "section" ]
                            |> Query.has [ notFoundMessage ]
            ]
