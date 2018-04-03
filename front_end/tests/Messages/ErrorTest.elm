module Messages.ErrorTest exposing (suite)

import Expect
import Fuzzer.Config as Config
import Html.Attributes as Attributes
import Http exposing (Error(NetworkError))
import Model exposing (Model)
import RemoteData exposing (RemoteData(Failure))
import Routing.Route exposing (Route(ListSurveyResultsRoute))
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
                "displays an error message when data cannot be fetched"
              <|
                \config ->
                    let
                        model =
                            Model
                                (Failure NetworkError)
                                config
                                ListSurveyResultsRoute

                        errorMessage =
                            Selector.attribute
                                (Attributes.attribute
                                    "data-name"
                                    "error-message"
                                )
                    in
                        model
                            |> View.view
                            |> Query.fromHtml
                            |> Query.find [ tag "section" ]
                            |> Query.has [ errorMessage ]
            ]
