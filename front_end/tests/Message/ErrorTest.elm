module Message.ErrorTest exposing (suite)

import Expect
import Factory.Http.Response as Response
import Fuzzer.Config as Config
import Html.Attributes as Attributes
import Http exposing (Error(BadStatus, BadPayload, NetworkError, Timeout))
import Model exposing (Model)
import RemoteData exposing (RemoteData(Failure))
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
                                (Failure NetworkError)
                                config
                                ListSurveyResultsRoute

                        errorMessage =
                            Selector.attribute
                                (Attributes.attribute
                                    "data-name"
                                    "error-message"
                                )
                    in
                        model
                            |> View.view
                            |> Query.fromHtml
                            |> Query.find [ tag "section", errorMessage ]
                            |> Query.has [ text "Is the server running?" ]
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
                                (Failure (BadStatus response))
                                config
                                ListSurveyResultsRoute

                        errorMessage =
                            Selector.attribute
                                (Attributes.attribute
                                    "data-name"
                                    "error-message"
                                )
                    in
                        model
                            |> View.view
                            |> Query.fromHtml
                            |> Query.find [ tag "section", errorMessage ]
                            |> Query.has [ text "BadStatus Error" ]
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
                                (Failure (BadPayload "BadPayload" response))
                                config
                                ListSurveyResultsRoute

                        errorMessage =
                            Selector.attribute
                                (Attributes.attribute
                                    "data-name"
                                    "error-message"
                                )
                    in
                        model
                            |> View.view
                            |> Query.fromHtml
                            |> Query.find [ tag "section", errorMessage ]
                            |> Query.has [ text "Decoding Failed: BadPayload" ]
            , fuzz
                config
                "displays an error message when error is any other Http error"
              <|
                \config ->
                    let
                        model =
                            Model
                                (Failure Timeout)
                                config
                                ListSurveyResultsRoute

                        errorMessage =
                            Selector.attribute
                                (Attributes.attribute
                                    "data-name"
                                    "error-message"
                                )
                    in
                        model
                            |> View.view
                            |> Query.fromHtml
                            |> Query.find [ tag "section", errorMessage ]
                            |> Query.has [ text "Timeout" ]
            ]
