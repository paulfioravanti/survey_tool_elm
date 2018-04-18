module ViewTest exposing (suite)

import Expect
import Fuzzer.Config as Config
import Html exposing (Html, text)
import Html.Styled
import Model exposing (Model)
import RemoteData exposing (RemoteData(NotRequested))
import Router
import Router.Route
    exposing
        ( Route
            ( ListSurveyResultsRoute
            , SurveyResultDetailRoute
            )
        )
import Test exposing (Test, describe, fuzz)
import Test.Html.Query as Query


suite : Test
suite =
    let
        config =
            Config.fuzzer
    in
        describe "view"
            [ describe
                "when no data has been requested on the SurveyResultsList page"
                [ fuzz config "it displays a blank page" <|
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
                                |> Router.route
                                |> Html.Styled.toUnstyled
                                |> Query.fromHtml
                                |> Query.children []
                                |> Query.count (Expect.equal 0)
                ]
            , describe
                "when no data has been requested on a SurveyResultDetail page"
                [ fuzz config "it displays a blank page" <|
                    \config ->
                        let
                            model =
                                Model
                                    config
                                    (SurveyResultDetailRoute "10")
                                    NotRequested
                                    NotRequested
                        in
                            model
                                |> Router.route
                                |> Html.Styled.toUnstyled
                                |> Query.fromHtml
                                |> Query.children []
                                |> Query.count (Expect.equal 0)
                ]
            ]
