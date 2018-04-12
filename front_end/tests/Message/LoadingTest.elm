module Message.LoadingTest exposing (suite)

import Expect
import Fuzzer.Config as Config
import Html.Attributes as Attributes
import Html.Styled
import Model exposing (Model)
import RemoteData exposing (RemoteData(NotRequested, Requesting))
import Router
import Routing.Route
    exposing
        ( Route
            ( ListSurveyResultsRoute
            , SurveyResultDetailRoute
            )
        )
import Test exposing (Test, describe, fuzz)
import Test.Html.Query as Query
import Test.Html.Selector exposing (attribute, tag)


suite : Test
suite =
    let
        config =
            Config.fuzzer

        loadingMessage =
            attribute
                (Attributes.attribute
                    "data-name"
                    "loading-message"
                )
    in
        describe "view"
            [ describe
                "when data has been requested on the SurveyResultsList page"
                [ fuzz config "displays a loading message" <|
                    \config ->
                        let
                            model =
                                Model
                                    config
                                    ListSurveyResultsRoute
                                    NotRequested
                                    Requesting
                        in
                            model
                                |> Router.route
                                |> Html.Styled.toUnstyled
                                |> Query.fromHtml
                                |> Query.find [ tag "section" ]
                                |> Query.has [ loadingMessage ]
                ]
            , describe
                "when data has been requested on a SurveyResultDetail page"
                [ fuzz config "displays a loading message" <|
                    \config ->
                        let
                            model =
                                Model
                                    config
                                    (SurveyResultDetailRoute "10")
                                    Requesting
                                    NotRequested
                        in
                            model
                                |> Router.route
                                |> Html.Styled.toUnstyled
                                |> Query.fromHtml
                                |> Query.find [ tag "section" ]
                                |> Query.has [ loadingMessage ]
                ]
            ]
