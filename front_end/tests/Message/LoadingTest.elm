module Message.LoadingTest exposing (suite)

import Config exposing (Config)
import Expect
import Fuzz exposing (Fuzzer)
import Fuzzer.Config as Config
import Fuzzer.Locale as Locale
import I18Next exposing (Translations)
import Html.Attributes as Attributes
import Html.Styled
import Locale exposing (Locale)
import Model exposing (Model)
import RemoteData exposing (RemoteData(NotRequested, Requesting))
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
import Test.Html.Selector as Selector exposing (Selector, tag)


suite : Test
suite =
    let
        config =
            Config.fuzzer

        locale =
            Locale.fuzzer

        loadingMessage =
            Selector.attribute
                (Attributes.attribute "data-name" "loading-message")
    in
        describe "view"
            [ surveyResultsListPageTest config locale loadingMessage
            , surveyResultDetailPageTest config locale loadingMessage
            ]


surveyResultsListPageTest : Fuzzer Config -> Fuzzer Locale -> Selector -> Test
surveyResultsListPageTest config locale loadingMessage =
    describe "when data has been requested on the SurveyResultsList page"
        [ fuzz2 config locale "displays a loading message" <|
            \config locale ->
                let
                    model =
                        Model
                            config
                            locale
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


surveyResultDetailPageTest : Fuzzer Config -> Fuzzer Locale -> Selector -> Test
surveyResultDetailPageTest config locale loadingMessage =
    describe "when data has been requested on a SurveyResultDetail page"
        [ fuzz2 config locale "displays a loading message" <|
            \config locale ->
                let
                    model =
                        Model
                            config
                            locale
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
