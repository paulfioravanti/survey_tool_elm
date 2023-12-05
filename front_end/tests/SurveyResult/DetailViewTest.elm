module SurveyResult.DetailViewTest exposing (all)

import Expect
import Fuzz exposing (Fuzzer)
import Fuzzer.Error as Error
import Fuzzer.Language as Language
import Html.Attributes as Attributes
import Html.Styled as Html exposing (Html)
import Http exposing (Error)
import Language exposing (Language)
import RemoteData exposing (RemoteData)
import SurveyResult exposing (SurveyResult)
import Test exposing (Test, describe, fuzz, fuzz2)
import Test.Html.Query as Query
import Test.Html.Selector as Selector exposing (Selector, tag)


all : Test
all =
    let
        randomLanguage : Fuzzer Language
        randomLanguage =
            Language.fuzzer
    in
    describe "SurveyResult.detailView"
        [ viewWhenDataIsNotAskedTest randomLanguage
        , viewWhenDataIsLoadingTest randomLanguage
        , viewWhenDataIsNotFoundFailureTest randomLanguage
        , viewWhenDataIsFailureTest randomLanguage
        ]


viewWhenDataIsNotAskedTest : Fuzzer Language -> Test
viewWhenDataIsNotAskedTest randomLanguage =
    let
        surveyResult : RemoteData Error SurveyResult
        surveyResult =
            RemoteData.NotAsked
    in
    describe "when survey result web data is NotAsked"
        [ fuzz randomLanguage "displays a blank page" <|
            \language ->
                let
                    expectedHtml : Html msg
                    expectedHtml =
                        Html.text ""

                    actualHtml : Html msg
                    actualHtml =
                        SurveyResult.detailView language surveyResult
                in
                Expect.equal expectedHtml actualHtml
        ]


viewWhenDataIsLoadingTest : Fuzzer Language -> Test
viewWhenDataIsLoadingTest randomLanguage =
    let
        surveyResult : RemoteData Error SurveyResult
        surveyResult =
            RemoteData.Loading

        loadingMessage : Selector
        loadingMessage =
            Selector.attribute
                (Attributes.attribute "data-name" "loading-message")
    in
    describe "when survey result web data is Loading"
        [ fuzz randomLanguage "displays a loading message" <|
            \language ->
                let
                    html : Html msg
                    html =
                        SurveyResult.detailView language surveyResult
                in
                html
                    |> Html.toUnstyled
                    |> Query.fromHtml
                    |> Query.has [ tag "section", loadingMessage ]
        ]


viewWhenDataIsNotFoundFailureTest : Fuzzer Language -> Test
viewWhenDataIsNotFoundFailureTest randomLanguage =
    let
        httpError : Error
        httpError =
            Http.BadStatus 404

        surveyResult : RemoteData Error SurveyResult
        surveyResult =
            RemoteData.Failure httpError

        errorMessage : Selector
        errorMessage =
            Selector.attribute
                (Attributes.attribute "data-name" "error-message")

        badStatusMessage : Selector
        badStatusMessage =
            Selector.attribute
                (Attributes.attribute "data-name" "bad-status-message")
    in
    describe "when survey result list web data is NotFound Failure"
        [ fuzz randomLanguage "displays an error message" <|
            \language ->
                let
                    html : Html msg
                    html =
                        SurveyResult.detailView language surveyResult
                in
                html
                    |> Html.toUnstyled
                    |> Query.fromHtml
                    |> Query.find [ tag "section", errorMessage ]
                    |> Query.has [ tag "div", badStatusMessage ]
        ]


viewWhenDataIsFailureTest : Fuzzer Language -> Test
viewWhenDataIsFailureTest randomLanguage =
    let
        randomHttpError : Fuzzer Error
        randomHttpError =
            Error.fuzzer

        errorMessage : Selector
        errorMessage =
            Selector.attribute
                (Attributes.attribute "data-name" "error-message")
    in
    describe "when survey result web data is Failure"
        [ fuzz2 randomLanguage randomHttpError "displays an error message" <|
            \language httpError ->
                let
                    surveyResult : RemoteData Error SurveyResult
                    surveyResult =
                        RemoteData.Failure httpError

                    html : Html msg
                    html =
                        SurveyResult.detailView language surveyResult
                in
                html
                    |> Html.toUnstyled
                    |> Query.fromHtml
                    |> Query.has [ tag "section", errorMessage ]
        ]
