module Message.LoadingTest exposing (suite)

import Config exposing (Config)
import Expect
import Fuzz exposing (Fuzzer)
import Fuzzer.Config as Config
import I18Next exposing (Translations)
import Html.Attributes as Attributes
import Html.Styled
import Locale exposing (Language(En))
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
import Test exposing (Test, describe, fuzz)
import Test.Html.Query as Query
import Test.Html.Selector as Selector exposing (Selector, tag)


suite : Test
suite =
    let
        config =
            Config.fuzzer

        loadingMessage =
            Selector.attribute
                (Attributes.attribute "data-name" "loading-message")
    in
        describe "view"
            [ surveyResultsListPageTest config loadingMessage
            , surveyResultDetailPageTest config loadingMessage
            ]


surveyResultsListPageTest : Fuzzer Config -> Selector -> Test
surveyResultsListPageTest config loadingMessage =
    describe "when data has been requested on the SurveyResultsList page"
        [ fuzz config "displays a loading message" <|
            \config ->
                let
                    model =
                        Model
                            config
                            En
                            ListSurveyResultsRoute
                            NotRequested
                            Requesting
                            I18Next.initialTranslations
                in
                    model
                        |> Router.route
                        |> Html.Styled.toUnstyled
                        |> Query.fromHtml
                        |> Query.find [ tag "section" ]
                        |> Query.has [ loadingMessage ]
        ]


surveyResultDetailPageTest : Fuzzer Config -> Selector -> Test
surveyResultDetailPageTest config loadingMessage =
    describe "when data has been requested on a SurveyResultDetail page"
        [ fuzz config "displays a loading message" <|
            \config ->
                let
                    model =
                        Model
                            config
                            En
                            (SurveyResultDetailRoute "10")
                            Requesting
                            NotRequested
                            I18Next.initialTranslations
                in
                    model
                        |> Router.route
                        |> Html.Styled.toUnstyled
                        |> Query.fromHtml
                        |> Query.find [ tag "section" ]
                        |> Query.has [ loadingMessage ]
        ]
