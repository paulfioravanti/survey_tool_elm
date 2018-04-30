module Message.ErrorTest exposing (suite)

import Config exposing (Config)
import Expect
import Fuzz exposing (Fuzzer)
import Fuzzer.Http.Response as Response
import Fuzzer.Config as Config
import Fuzzer.Locale as Locale
import Fuzzer.Navigation.Location as Location
import Html.Attributes as Attributes
import Html.Styled
import Http exposing (Error(BadStatus, BadPayload, NetworkError, Timeout))
import I18Next exposing (Translations)
import Locale exposing (Locale)
import Main
import Model exposing (Model)
import Navigation exposing (Location)
import RemoteData exposing (RemoteData(Failure, NotRequested))
import Route
    exposing
        ( Route
            ( ListSurveyResultsRoute
            , SurveyResultDetailRoute
            )
        )
import Test exposing (Test, describe, fuzz3, fuzz4)
import Test.Html.Query as Query
import Test.Html.Selector as Selector exposing (Selector, tag, text)


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

        errorMessage =
            Selector.attribute
                (Attributes.attribute "data-name" "error-message")
    in
        describe "view"
            [ networkErrorTest config locale location errorMessage
            , badStatusTest config locale location response errorMessage
            , badPayloadTest config locale location response errorMessage
            , otherErrorTest config locale location errorMessage
            ]


networkErrorTest :
    Fuzzer Config
    -> Fuzzer Locale
    -> Fuzzer Location
    -> Selector
    -> Test
networkErrorTest config locale location errorMessage =
    let
        networkErrorMessage =
            Selector.attribute
                (Attributes.attribute "data-name" "network-error-message")
    in
        describe "when error is a NetworkError"
            [ fuzz3 config locale location "displays an error message" <|
                \config locale location ->
                    let
                        model =
                            Model
                                config
                                locale
                                location
                                ListSurveyResultsRoute
                                NotRequested
                                (Failure NetworkError)
                    in
                        model
                            |> Main.view
                            |> Query.fromHtml
                            |> Query.find [ tag "section", errorMessage ]
                            |> Query.has [ networkErrorMessage ]
            ]


badStatusTest :
    Fuzzer Config
    -> Fuzzer Locale
    -> Fuzzer Location
    -> Fuzzer (Http.Response String)
    -> Selector
    -> Test
badStatusTest config locale location response errorMessage =
    let
        badStatusMessage =
            Selector.attribute
                (Attributes.attribute "data-name" "bad-status-message")
    in
        describe "when error is a BadStatus"
            [ describe "when requesting the survey results list page"
                [ fuzz4
                    config
                    locale
                    location
                    response
                    "displays an error message"
                    (\config locale location response ->
                        let
                            model =
                                Model
                                    config
                                    locale
                                    location
                                    ListSurveyResultsRoute
                                    NotRequested
                                    (Failure (BadStatus response))
                        in
                            model
                                |> Main.view
                                |> Query.fromHtml
                                |> Query.find [ tag "section", errorMessage ]
                                |> Query.has [ badStatusMessage ]
                    )
                ]
            , describe "when requesting a survey result detail page"
                [ fuzz4
                    config
                    locale
                    location
                    response
                    "displays an error message"
                    (\config locale location response ->
                        let
                            model =
                                Model
                                    config
                                    locale
                                    location
                                    (SurveyResultDetailRoute "1")
                                    (Failure (BadStatus response))
                                    NotRequested
                        in
                            model
                                |> Main.view
                                |> Query.fromHtml
                                |> Query.find [ tag "section", errorMessage ]
                                |> Query.has [ badStatusMessage ]
                    )
                ]
            ]


badPayloadTest :
    Fuzzer Config
    -> Fuzzer Locale
    -> Fuzzer Location
    -> Fuzzer (Http.Response String)
    -> Selector
    -> Test
badPayloadTest config locale location response errorMessage =
    let
        badPayloadMessage =
            Selector.attribute
                (Attributes.attribute "data-name" "bad-payload-message")
    in
        describe "when error is a BadPayload"
            [ fuzz4
                config
                locale
                location
                response
                "displays an error message"
                (\config locale location response ->
                    let
                        model =
                            Model
                                config
                                locale
                                location
                                ListSurveyResultsRoute
                                NotRequested
                                (Failure (BadPayload "BadPayload" response))
                    in
                        model
                            |> Main.view
                            |> Query.fromHtml
                            |> Query.find [ tag "section", errorMessage ]
                            |> Query.has [ badPayloadMessage ]
                )
            ]


otherErrorTest :
    Fuzzer Config
    -> Fuzzer Locale
    -> Fuzzer Location
    -> Selector
    -> Test
otherErrorTest config locale location errorMessage =
    let
        otherErrorMessage =
            Selector.attribute
                (Attributes.attribute "data-name" "other-error-message")
    in
        describe "when error is any other Http error"
            [ describe "when requesting the survey results list page"
                [ fuzz3 config locale location "displays an error message" <|
                    \config locale location ->
                        let
                            model =
                                Model
                                    config
                                    locale
                                    location
                                    ListSurveyResultsRoute
                                    NotRequested
                                    (Failure Timeout)
                        in
                            model
                                |> Main.view
                                |> Query.fromHtml
                                |> Query.find [ tag "section", errorMessage ]
                                |> Query.has [ otherErrorMessage ]
                ]
            , describe "when requesting a survey result detail page"
                [ fuzz3 config locale location "displays an error message" <|
                    \config locale location ->
                        let
                            model =
                                Model
                                    config
                                    locale
                                    location
                                    (SurveyResultDetailRoute "1")
                                    (Failure Timeout)
                                    NotRequested
                        in
                            model
                                |> Main.view
                                |> Query.fromHtml
                                |> Query.find [ tag "section", errorMessage ]
                                |> Query.has [ otherErrorMessage ]
                ]
            ]
