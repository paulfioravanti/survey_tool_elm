module Message.NotFoundTest exposing (suite)

import Config exposing (Config)
import Expect
import Fuzz exposing (Fuzzer)
import Fuzzer.Config as Config
import Fuzzer.Http.Response as Response
import Fuzzer.Locale as Locale
import Html.Attributes as Attributes
import Html.Styled
import Http exposing (Error(BadStatus))
import I18Next exposing (Translations)
import Locale exposing (Locale)
import Model exposing (Model)
import RemoteData exposing (RemoteData(Failure, NotRequested))
import Route exposing (Route(NotFoundRoute, SurveyResultDetailRoute))
import Router
import Test exposing (Test, describe, fuzz2, fuzz3)
import Test.Html.Query as Query
import Test.Html.Selector as Selector exposing (tag)


suite : Test
suite =
    let
        config =
            Config.fuzzer

        locale =
            Locale.fuzzer

        response =
            Response.fuzzer
    in
        describe "view"
            [ unknownRouteTest config locale
            , unknownSurveyResult config locale
            ]


unknownRouteTest : Fuzzer Config -> Fuzzer Locale -> Test
unknownRouteTest config locale =
    let
        notFoundMessage =
            Selector.attribute
                (Attributes.attribute "data-name" "not-found-message")
    in
        describe "when route is unknown and page cannot be found"
            [ fuzz2 config locale "displays an error message" <|
                \config locale ->
                    let
                        model =
                            Model
                                config
                                locale
                                NotFoundRoute
                                NotRequested
                                NotRequested
                    in
                        model
                            |> Router.route
                            |> Html.Styled.toUnstyled
                            |> Query.fromHtml
                            |> Query.find [ tag "section" ]
                            |> Query.has [ notFoundMessage ]
            ]


unknownSurveyResult : Fuzzer Config -> Fuzzer Locale -> Test
unknownSurveyResult config locale =
    let
        response =
            Response.fuzzer

        notFoundMessage =
            Selector.attribute
                (Attributes.attribute "data-name" "not-found-message")
    in
        describe "when survey result detail cannot be found"
            [ fuzz3 config locale response "displays an error message" <|
                \config locale response ->
                    let
                        notFoundResponse =
                            { response
                                | status =
                                    { code = 404
                                    , message = "Not Found"
                                    }
                            }

                        model =
                            Model
                                config
                                locale
                                (SurveyResultDetailRoute "1")
                                (Failure (BadStatus notFoundResponse))
                                NotRequested
                    in
                        model
                            |> Router.route
                            |> Html.Styled.toUnstyled
                            |> Query.fromHtml
                            |> Query.find [ tag "section" ]
                            |> Query.has [ notFoundMessage ]
            ]
