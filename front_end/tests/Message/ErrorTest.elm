module Message.ErrorTest exposing (suite)

import Controller
import Expect
import Fuzzer.Http.Response as Response
import Fuzzer.Config as Config
import Html.Attributes as Attributes
import Html.Styled
import Http exposing (Error(BadStatus, BadPayload, NetworkError, Timeout))
import Model exposing (Model)
import RemoteData exposing (RemoteData(Failure, NotRequested))
import Routing.Route exposing (Route(ListSurveyResultsRoute))
import Test exposing (Test, describe, fuzz, fuzz2)
import Test.Html.Query as Query
import Test.Html.Selector as Selector exposing (tag, text)


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
                            |> Controller.render
                            |> Html.Styled.toUnstyled
                            |> Query.fromHtml
                            |> Query.find [ tag "section", errorMessage ]
                            |> Query.has [ networkErrorMessage ]
            , fuzz2
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
                            |> Controller.render
                            |> Html.Styled.toUnstyled
                            |> Query.fromHtml
                            |> Query.find [ tag "section", errorMessage ]
                            |> Query.has [ badStatusMessage ]
            , fuzz2
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
                            |> Controller.render
                            |> Html.Styled.toUnstyled
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
                            |> Controller.render
                            |> Html.Styled.toUnstyled
                            |> Query.fromHtml
                            |> Query.find [ tag "section", errorMessage ]
                            |> Query.has [ otherErrorMessage ]
            ]
