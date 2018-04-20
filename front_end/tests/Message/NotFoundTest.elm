module Message.NotFoundTest exposing (suite)

import Config exposing (Config)
import Expect
import Fuzz exposing (Fuzzer)
import Fuzzer.Config as Config
import Fuzzer.Http.Response as Response
import Html.Attributes as Attributes
import Html.Styled
import Http exposing (Error(BadStatus))
import I18Next exposing (Translations)
import Locale exposing (Language(En))
import Model exposing (Model)
import RemoteData exposing (RemoteData(Failure, NotRequested))
import Route exposing (Route(NotFoundRoute, SurveyResultDetailRoute))
import Router
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
    let
        notFoundMessage =
            Selector.attribute
                (Attributes.attribute "data-name" "not-found-message")
    in
        describe "when route is unknown and page cannot be found"
            [ fuzz config "displays an error message" <|
                \config ->
                    let
                        model =
                            Model
                                config
                                En
                                NotFoundRoute
                                NotRequested
                                NotRequested
                                I18Next.initialTranslations
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

        notFoundMessage =
            Selector.attribute
                (Attributes.attribute "data-name" "not-found-message")
    in
        describe "when survey result detail cannot be found"
            [ fuzz2 config response "displays an error message" <|
                \config response ->
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
                                En
                                (SurveyResultDetailRoute "1")
                                (Failure (BadStatus notFoundResponse))
                                NotRequested
                                I18Next.initialTranslations
                    in
                        model
                            |> Router.route
                            |> Html.Styled.toUnstyled
                            |> Query.fromHtml
                            |> Query.find [ tag "section" ]
                            |> Query.has [ notFoundMessage ]
            ]
