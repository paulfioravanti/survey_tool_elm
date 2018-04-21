module Message.ErrorTest exposing (suite)

import Config exposing (Config)
import Expect
import Fuzz exposing (Fuzzer)
import Fuzzer.Http.Response as Response
import Fuzzer.Config as Config
import Fuzzer.Locale as Locale
import Html.Attributes as Attributes
import Html.Styled
import Http exposing (Error(BadStatus, BadPayload, NetworkError, Timeout))
import I18Next exposing (Translations)
import Locale exposing (Locale)
import Model exposing (Model)
import RemoteData exposing (RemoteData(Failure, NotRequested))
import Route
    exposing
        ( Route
            ( ListSurveyResultsRoute
            , SurveyResultDetailRoute
            )
        )
import Router
import Test exposing (Test, describe, fuzz2, fuzz3)
import Test.Html.Query as Query
import Test.Html.Selector as Selector exposing (Selector, tag, text)


suite : Test
suite =
    let
        config =
            Config.fuzzer

        locale =
            Locale.fuzzer

        response =
            Response.fuzzer

        errorMessage =
            Selector.attribute
                (Attributes.attribute "data-name" "error-message")
    in
        describe "view"
            [ networkErrorTest config locale errorMessage
            , badStatusTest config locale response errorMessage
            , badPayloadTest config locale response errorMessage
            , otherErrorTest config locale errorMessage
            ]


networkErrorTest : Fuzzer Config -> Fuzzer Locale -> Selector -> Test
networkErrorTest config locale errorMessage =
    let
        networkErrorMessage =
            Selector.attribute
                (Attributes.attribute "data-name" "network-error-message")
    in
        describe "when error is a NetworkError"
            [ fuzz2 config locale "displays an error message" <|
                \config locale ->
                    let
                        model =
                            Model
                                config
                                locale
                                ListSurveyResultsRoute
                                NotRequested
                                (Failure NetworkError)
                    in
                        model
                            |> Router.route
                            |> Html.Styled.toUnstyled
                            |> Query.fromHtml
                            |> Query.find [ tag "section", errorMessage ]
                            |> Query.has [ networkErrorMessage ]
            ]


badStatusTest :
    Fuzzer Config
    -> Fuzzer Locale
    -> Fuzzer (Http.Response String)
    -> Selector
    -> Test
badStatusTest config locale response errorMessage =
    let
        badStatusMessage =
            Selector.attribute
                (Attributes.attribute "data-name" "bad-status-message")
    in
        describe "when error is a BadStatus"
            [ describe "when requesting the survey results list page"
                [ fuzz3 config locale response "displays an error message" <|
                    \config locale response ->
                        let
                            model =
                                Model
                                    config
                                    locale
                                    ListSurveyResultsRoute
                                    NotRequested
                                    (Failure (BadStatus response))
                        in
                            model
                                |> Router.route
                                |> Html.Styled.toUnstyled
                                |> Query.fromHtml
                                |> Query.find [ tag "section", errorMessage ]
                                |> Query.has [ badStatusMessage ]
                ]
            , describe "when requesting a survey result detail page"
                [ fuzz3 config locale response "displays an error message" <|
                    \config locale response ->
                        let
                            model =
                                Model
                                    config
                                    locale
                                    (SurveyResultDetailRoute "1")
                                    (Failure (BadStatus response))
                                    NotRequested
                        in
                            model
                                |> Router.route
                                |> Html.Styled.toUnstyled
                                |> Query.fromHtml
                                |> Query.find [ tag "section", errorMessage ]
                                |> Query.has [ badStatusMessage ]
                ]
            ]


badPayloadTest :
    Fuzzer Config
    -> Fuzzer Locale
    -> Fuzzer (Http.Response String)
    -> Selector
    -> Test
badPayloadTest config locale response errorMessage =
    let
        badPayloadMessage =
            Selector.attribute
                (Attributes.attribute "data-name" "bad-payload-message")
    in
        describe "when error is a BadPayload"
            [ fuzz3 config locale response "displays an error message" <|
                \config locale response ->
                    let
                        model =
                            Model
                                config
                                locale
                                ListSurveyResultsRoute
                                NotRequested
                                (Failure (BadPayload "BadPayload" response))
                    in
                        model
                            |> Router.route
                            |> Html.Styled.toUnstyled
                            |> Query.fromHtml
                            |> Query.find [ tag "section", errorMessage ]
                            |> Query.has [ badPayloadMessage ]
            ]


otherErrorTest : Fuzzer Config -> Fuzzer Locale -> Selector -> Test
otherErrorTest config locale errorMessage =
    let
        otherErrorMessage =
            Selector.attribute
                (Attributes.attribute "data-name" "other-error-message")
    in
        describe "when error is any other Http error"
            [ describe "when requesting the survey results list page"
                [ fuzz2 config locale "displays an error message" <|
                    \config locale ->
                        let
                            model =
                                Model
                                    config
                                    locale
                                    ListSurveyResultsRoute
                                    NotRequested
                                    (Failure Timeout)
                        in
                            model
                                |> Router.route
                                |> Html.Styled.toUnstyled
                                |> Query.fromHtml
                                |> Query.find [ tag "section", errorMessage ]
                                |> Query.has [ otherErrorMessage ]
                ]
            , describe "when requesting a survey result detail page"
                [ fuzz2 config locale "displays an error message" <|
                    \config locale ->
                        let
                            model =
                                Model
                                    config
                                    locale
                                    (SurveyResultDetailRoute "1")
                                    (Failure Timeout)
                                    NotRequested
                        in
                            model
                                |> Router.route
                                |> Html.Styled.toUnstyled
                                |> Query.fromHtml
                                |> Query.find [ tag "section", errorMessage ]
                                |> Query.has [ otherErrorMessage ]
                ]
            ]
