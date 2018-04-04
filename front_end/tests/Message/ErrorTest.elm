module Message.ErrorTest exposing (suite)

import Expect
import Factory.Http.Response as Response
import Fuzzer.Config as Config
import Html.Attributes as Attributes
import Http exposing (Error(BadStatus, BadPayload, NetworkError, Timeout))
import Model exposing (Model)
import RemoteData exposing (RemoteData(Failure, NotRequested))
import Routing.Route exposing (Route(ListSurveyResultsRoute))
import Test exposing (Test, describe, fuzz)
import Test.Html.Query as Query
import Test.Html.Selector as Selector exposing (tag, text)
import View


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
    in
        describe "view"
            [ fuzz
                config
                "displays an error message when error is a NetworkError"
              <|
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
                            |> View.view
                            |> Query.fromHtml
                            |> Query.find [ tag "section", errorMessage ]
                            |> Query.has [ networkErrorMessage ]
            , fuzz
                config
                "displays an error message when error is a BadStatus"
              <|
                \config ->
                    let
                        response =
                            Response.factory "BadStatus Error"

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
                            |> View.view
                            |> Query.fromHtml
                            |> Query.find [ tag "section", errorMessage ]
                            |> Query.has [ badStatusMessage ]
            , fuzz
                config
                "displays an error message when error is a BadPayload"
              <|
                \config ->
                    let
                        response =
                            Response.factory "BadPayload Error"

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
                            |> View.view
                            |> Query.fromHtml
                            |> Query.find [ tag "section", errorMessage ]
                            |> Query.has [ badPayloadMessage ]
            , fuzz
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
                            |> View.view
                            |> Query.fromHtml
                            |> Query.find [ tag "section", errorMessage ]
                            |> Query.has [ otherErrorMessage ]
            ]
