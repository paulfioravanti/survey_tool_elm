module Message.ErrorTest exposing (suite)

import Config exposing (Config)
import Expect
import Fuzz exposing (Fuzzer)
import Fuzzer.Http.Response as Response
import Fuzzer.Config as Config
import Html.Attributes as Attributes
import Html.Styled
import Http exposing (Error(BadStatus, BadPayload, NetworkError, Timeout))
import Model exposing (Model)
import RemoteData exposing (RemoteData(Failure, NotRequested))
import Router
import Routing.Route exposing (Route(ListSurveyResultsRoute))
import Test exposing (Test, describe, fuzz, fuzz2)
import Test.Html.Query as Query
import Test.Html.Selector as Selector exposing (Selector, tag, text)


suite : Test
suite =
    let
        config =
            Config.fuzzer

        errorMessage =
            Selector.attribute
                (Attributes.attribute
                    "data-name"
                    "error-message"
                )

        response =
            Response.fuzzer
    in
        describe "view"
            [ networkErrorTest config errorMessage
            , badStatusTest config response errorMessage
            , badPayloadTest config response errorMessage
            , otherErrorTest config errorMessage
            ]


networkErrorTest : Fuzzer Config -> Selector -> Test
networkErrorTest config errorMessage =
    fuzz config "displays an error message when error is a NetworkError" <|
        \config ->
            let
                model =
                    Model
                        config
                        ListSurveyResultsRoute
                        NotRequested
                        (Failure NetworkError)

                networkErrorMessage =
                    Selector.attribute
                        (Attributes.attribute
                            "data-name"
                            "network-error-message"
                        )
            in
                model
                    |> Router.route
                    |> Html.Styled.toUnstyled
                    |> Query.fromHtml
                    |> Query.find [ tag "section", errorMessage ]
                    |> Query.has [ networkErrorMessage ]


badStatusTest :
    Fuzzer Config
    -> Fuzzer (Http.Response String)
    -> Selector
    -> Test
badStatusTest config response errorMessage =
    fuzz2
        config
        response
        "displays an error message when error is a BadStatus"
    <|
        \config response ->
            let
                model =
                    Model
                        config
                        ListSurveyResultsRoute
                        NotRequested
                        (Failure (BadStatus response))

                badStatusMessage =
                    Selector.attribute
                        (Attributes.attribute
                            "data-name"
                            "bad-status-message"
                        )
            in
                model
                    |> Router.route
                    |> Html.Styled.toUnstyled
                    |> Query.fromHtml
                    |> Query.find [ tag "section", errorMessage ]
                    |> Query.has [ badStatusMessage ]


badPayloadTest :
    Fuzzer Config
    -> Fuzzer (Http.Response String)
    -> Selector
    -> Test
badPayloadTest config response errorMessage =
    fuzz2
        config
        response
        "displays an error message when error is a BadPayload"
    <|
        \config response ->
            let
                model =
                    Model
                        config
                        ListSurveyResultsRoute
                        NotRequested
                        (Failure (BadPayload "BadPayload" response))

                badPayloadMessage =
                    Selector.attribute
                        (Attributes.attribute
                            "data-name"
                            "bad-payload-message"
                        )
            in
                model
                    |> Router.route
                    |> Html.Styled.toUnstyled
                    |> Query.fromHtml
                    |> Query.find [ tag "section", errorMessage ]
                    |> Query.has [ badPayloadMessage ]


otherErrorTest : Fuzzer Config -> Selector -> Test
otherErrorTest config errorMessage =
    fuzz
        config
        "displays an error message when error is any other Http error"
    <|
        \config ->
            let
                model =
                    Model
                        config
                        ListSurveyResultsRoute
                        NotRequested
                        (Failure Timeout)

                otherErrorMessage =
                    Selector.attribute
                        (Attributes.attribute
                            "data-name"
                            "other-error-message"
                        )
            in
                model
                    |> Router.route
                    |> Html.Styled.toUnstyled
                    |> Query.fromHtml
                    |> Query.find [ tag "section", errorMessage ]
                    |> Query.has [ otherErrorMessage ]
