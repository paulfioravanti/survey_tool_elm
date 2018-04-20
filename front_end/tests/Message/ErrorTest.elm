module Message.ErrorTest exposing (suite)

import Config exposing (Config)
import Expect
import Fuzz exposing (Fuzzer)
import Fuzzer.Http.Response as Response
import Fuzzer.Config as Config
import Html.Attributes as Attributes
import Html.Styled
import Http exposing (Error(BadStatus, BadPayload, NetworkError, Timeout))
import I18Next exposing (Translations)
import Locale exposing (Language(En))
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
import Test exposing (Test, describe, fuzz, fuzz2)
import Test.Html.Query as Query
import Test.Html.Selector as Selector exposing (Selector, tag, text)


suite : Test
suite =
    let
        config =
            Config.fuzzer

        response =
            Response.fuzzer

        errorMessage =
            Selector.attribute
                (Attributes.attribute "data-name" "error-message")
    in
        describe "view"
            [ networkErrorTest config errorMessage
            , badStatusTest config response errorMessage
            , badPayloadTest config response errorMessage
            , otherErrorTest config errorMessage
            ]


networkErrorTest : Fuzzer Config -> Selector -> Test
networkErrorTest config errorMessage =
    let
        networkErrorMessage =
            Selector.attribute
                (Attributes.attribute "data-name" "network-error-message")
    in
        describe "when error is a NetworkError"
            [ fuzz config "displays an error message" <|
                \config ->
                    let
                        model =
                            Model
                                config
                                En
                                ListSurveyResultsRoute
                                NotRequested
                                (Failure NetworkError)
                                I18Next.initialTranslations
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
    -> Fuzzer (Http.Response String)
    -> Selector
    -> Test
badStatusTest config response errorMessage =
    let
        badStatusMessage =
            Selector.attribute
                (Attributes.attribute "data-name" "bad-status-message")
    in
        describe "when error is a BadStatus"
            [ describe "when requesting the survey results list page"
                [ fuzz2 config response "displays an error message" <|
                    \config response ->
                        let
                            model =
                                Model
                                    config
                                    En
                                    ListSurveyResultsRoute
                                    NotRequested
                                    (Failure (BadStatus response))
                                    I18Next.initialTranslations
                        in
                            model
                                |> Router.route
                                |> Html.Styled.toUnstyled
                                |> Query.fromHtml
                                |> Query.find [ tag "section", errorMessage ]
                                |> Query.has [ badStatusMessage ]
                ]
            , describe "when requesting a survey result detail page"
                [ fuzz2 config response "displays an error message" <|
                    \config response ->
                        let
                            model =
                                Model
                                    config
                                    En
                                    (SurveyResultDetailRoute "1")
                                    (Failure (BadStatus response))
                                    NotRequested
                                    I18Next.initialTranslations
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
    -> Fuzzer (Http.Response String)
    -> Selector
    -> Test
badPayloadTest config response errorMessage =
    let
        badPayloadMessage =
            Selector.attribute
                (Attributes.attribute "data-name" "bad-payload-message")
    in
        describe "when error is a BadPayload"
            [ fuzz2 config response "displays an error message" <|
                \config response ->
                    let
                        model =
                            Model
                                config
                                En
                                ListSurveyResultsRoute
                                NotRequested
                                (Failure (BadPayload "BadPayload" response))
                                I18Next.initialTranslations
                    in
                        model
                            |> Router.route
                            |> Html.Styled.toUnstyled
                            |> Query.fromHtml
                            |> Query.find [ tag "section", errorMessage ]
                            |> Query.has [ badPayloadMessage ]
            ]


otherErrorTest : Fuzzer Config -> Selector -> Test
otherErrorTest config errorMessage =
    let
        otherErrorMessage =
            Selector.attribute
                (Attributes.attribute "data-name" "other-error-message")
    in
        describe "when error is any other Http error"
            [ describe "when requesting the survey results list page"
                [ fuzz config "displays an error message" <|
                    \config ->
                        let
                            model =
                                Model
                                    config
                                    En
                                    ListSurveyResultsRoute
                                    NotRequested
                                    (Failure Timeout)
                                    I18Next.initialTranslations
                        in
                            model
                                |> Router.route
                                |> Html.Styled.toUnstyled
                                |> Query.fromHtml
                                |> Query.find [ tag "section", errorMessage ]
                                |> Query.has [ otherErrorMessage ]
                ]
            , describe "when requesting a survey result detail page"
                [ fuzz config "displays an error message" <|
                    \config ->
                        let
                            model =
                                Model
                                    config
                                    En
                                    (SurveyResultDetailRoute "1")
                                    (Failure Timeout)
                                    NotRequested
                                    I18Next.initialTranslations
                        in
                            model
                                |> Router.route
                                |> Html.Styled.toUnstyled
                                |> Query.fromHtml
                                |> Query.find [ tag "section", errorMessage ]
                                |> Query.has [ otherErrorMessage ]
                ]
            ]
