module Message.LoadingTest exposing (suite)

import Config exposing (Config)
import Expect
import Fuzz exposing (Fuzzer)
import Fuzzer.Config as Config
import Fuzzer.Locale as Locale
import Fuzzer.Navigation.Location as Location
import I18Next exposing (Translations)
import Html.Attributes as Attributes
import Html.Styled
import Locale exposing (Locale)
import Model exposing (Model)
import Navigation exposing (Location)
import RemoteData exposing (RemoteData(NotRequested, Requesting))
import Route
    exposing
        ( Route
            ( ListSurveyResultsRoute
            , SurveyResultDetailRoute
            )
        )
import Router
import Test exposing (Test, describe, fuzz3)
import Test.Html.Query as Query
import Test.Html.Selector as Selector exposing (Selector, tag)


suite : Test
suite =
    let
        config =
            Config.fuzzer

        locale =
            Locale.fuzzer

        location =
            Location.fuzzer

        loadingMessage =
            Selector.attribute
                (Attributes.attribute "data-name" "loading-message")
    in
        describe "view"
            [ surveyResultsListPageTest config locale location loadingMessage
            , surveyResultDetailPageTest config locale location loadingMessage
            ]


surveyResultsListPageTest :
    Fuzzer Config
    -> Fuzzer Locale
    -> Fuzzer Location
    -> Selector
    -> Test
surveyResultsListPageTest config locale location loadingMessage =
    describe "when data has been requested on the SurveyResultsList page"
        [ fuzz3 config locale location "displays a loading message" <|
            \config locale location ->
                let
                    model =
                        Model
                            config
                            locale
                            location
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


surveyResultDetailPageTest :
    Fuzzer Config
    -> Fuzzer Locale
    -> Fuzzer Location
    -> Selector
    -> Test
surveyResultDetailPageTest config locale location loadingMessage =
    describe "when data has been requested on a SurveyResultDetail page"
        [ fuzz2 config locale location "displays a loading message" <|
            \config locale location ->
                let
                    model =
                        Model
                            config
                            locale
                            location
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
