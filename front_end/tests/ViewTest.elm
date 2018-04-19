module ViewTest exposing (suite)

import Expect
import Fuzzer.Config as Config
import Html exposing (Html, text)
import Html.Styled
import I18Next exposing (Translations)
import Locale exposing (Locale(En))
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
                                    En
                                    ListSurveyResultsRoute
                                    NotRequested
                                    NotRequested
                                    I18Next.initialTranslations
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
                                    En
                                    (SurveyResultDetailRoute "10")
                                    NotRequested
                                    NotRequested
                                    I18Next.initialTranslations
                        in
                            model
                                |> Router.route
                                |> Html.Styled.toUnstyled
                                |> Query.fromHtml
                                |> Query.children []
                                |> Query.count (Expect.equal 0)
                ]
            ]
