module Message.NotFoundTest exposing (suite)

import Config exposing (Config)
import Expect
import Fuzz exposing (Fuzzer)
import Fuzzer.Config as Config
import Fuzzer.Http.Response as Response
import Html.Attributes as Attributes
import Html.Styled
import Http exposing (Error(BadStatus))
import Model exposing (Model)
import RemoteData exposing (RemoteData(Failure, NotRequested))
import Router
import Routing.Route
    exposing
        ( Route
            ( NotFoundRoute
            , SurveyResultDetailRoute
            )
        )
import Test exposing (Test, describe, fuzz, fuzz2)
import Test.Html.Query as Query
import Test.Html.Selector as Selector exposing (tag)


suite : Test
suite =
    let
        config =
            Config.fuzzer

        response =
            Response.fuzzer
    in
        describe "view"
            [ unknownRouteTest config
            , unknownSurveyResult config
            ]


unknownRouteTest : Fuzzer Config -> Test
unknownRouteTest config =
    describe "when route is unknown and page cannot be found"
        [ fuzz config "displays an error message" <|
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
                        |> Router.route
                        |> Html.Styled.toUnstyled
                        |> Query.fromHtml
                        |> Query.find [ tag "section" ]
                        |> Query.has [ notFoundMessage ]
        ]


unknownSurveyResult : Fuzzer Config -> Test
unknownSurveyResult config =
    let
        response =
            Response.fuzzer
    in
        describe "when survey result detail cannot be found"
            [ fuzz2 config response "displays an error message" <|
                \config response ->
                    let
                        oldStatus =
                            response.status

                        notFoundStatus =
                            { oldStatus | code = 404 }

                        notFoundResponse =
                            { response | status = notFoundStatus }

                        model =
                            Model
                                config
                                (SurveyResultDetailRoute "1")
                                (Failure (BadStatus notFoundResponse))
                                NotRequested

                        notFoundMessage =
                            Selector.attribute
                                (Attributes.attribute
                                    "data-name"
                                    "not-found-message"
                                )
                    in
                        model
                            |> Router.route
                            |> Html.Styled.toUnstyled
                            |> Query.fromHtml
                            |> Query.find [ tag "section" ]
                            |> Query.has [ notFoundMessage ]
            ]
