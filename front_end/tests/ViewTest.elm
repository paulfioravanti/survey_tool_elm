module ViewTest exposing (suite)

import Expect
import Fuzzer.Config as Config
import Fuzzer.Locale as Locale
import Html exposing (Html, text)
import Html.Styled
import Locale exposing (Locale)
import Model exposing (Model)
import RemoteData exposing (RemoteData(NotRequested))
import Route
    exposing
        ( Route
            ( ListSurveyResultsRoute
            , SurveyResultDetailRoute
            )
        )
import Router
import Test exposing (Test, describe, fuzz2)
import Test.Html.Query as Query


suite : Test
suite =
    let
        config =
            Config.fuzzer

        locale =
            Locale.fuzzer
    in
        describe "view"
            [ describe
                "when no data has been requested on the SurveyResultsList page"
                [ fuzz2 config locale "it displays a blank page" <|
                    \config locale ->
                        let
                            model =
                                Model
                                    config
                                    locale
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
                [ fuzz2 config locale "it displays a blank page" <|
                    \config locale ->
                        let
                            model =
                                Model
                                    config
                                    locale
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
