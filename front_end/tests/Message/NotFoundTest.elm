module Message.NotFoundTest exposing (suite)

import Config exposing (Config)
import Expect
import Fuzz exposing (Fuzzer)
import Fuzzer.Config as Config
import Fuzzer.Http.Response as Response
import Fuzzer.Locale as Locale
import Fuzzer.Navigation.Location as Location
import Html.Attributes as Attributes
import Html.Styled
import Http exposing (Error(BadStatus))
import I18Next exposing (Translations)
import Locale exposing (Locale)
import Main
import Model exposing (Model)
import Navigation exposing (Location)
import RemoteData exposing (RemoteData(Failure, NotRequested))
import Route exposing (Route(NotFoundRoute, SurveyResultDetailRoute))
import Test exposing (Test, describe, fuzz3, fuzz4)
import Test.Html.Query as Query
import Test.Html.Selector as Selector exposing (tag)


suite : Test
suite =
    let
        config =
            Config.fuzzer

        locale =
            Locale.fuzzer

        location =
            Location.fuzzer

        response =
            Response.fuzzer
    in
        describe "view"
            [ unknownRouteTest config locale location
            , unknownSurveyResult config locale location
            ]


unknownRouteTest : Fuzzer Config -> Fuzzer Locale -> Fuzzer Location -> Test
unknownRouteTest config locale location =
    let
        notFoundMessage =
            Selector.attribute
                (Attributes.attribute "data-name" "not-found-message")
    in
        describe "when route is unknown and page cannot be found"
            [ fuzz3 config locale location "displays an error message" <|
                \config locale location ->
                    let
                        model =
                            Model
                                config
                                locale
                                location
                                NotFoundRoute
                                NotRequested
                                NotRequested
                    in
                        model
                            |> Main.view
                            |> Query.fromHtml
                            |> Query.find [ tag "section" ]
                            |> Query.has [ notFoundMessage ]
            ]


unknownSurveyResult : Fuzzer Config -> Fuzzer Locale -> Fuzzer Location -> Test
unknownSurveyResult config locale location =
    let
        response =
            Response.fuzzer

        notFoundMessage =
            Selector.attribute
                (Attributes.attribute "data-name" "not-found-message")
    in
        describe "when survey result detail cannot be found"
            [ fuzz4
                config
                locale
                location
                response
                "displays an error message"
                (\config locale location response ->
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
                                location
                                (SurveyResultDetailRoute "1")
                                (Failure (BadStatus notFoundResponse))
                                NotRequested
                    in
                        model
                            |> Main.view
                            |> Query.fromHtml
                            |> Query.find [ tag "section" ]
                            |> Query.has [ notFoundMessage ]
                )
            ]
