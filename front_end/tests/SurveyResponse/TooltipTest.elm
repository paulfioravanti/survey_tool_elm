module SurveyResponse.TooltipTest exposing (suite)

import Dict exposing (Dict)
import Expect
import Fuzz exposing (Fuzzer)
import Fuzzer.Lang as Lang
import Html.Attributes as Attributes
import Html.Styled
import SurveyResponse.Tooltip as Tooltip
import Test exposing (Test, describe, fuzz, test)
import Test.Html.Query as Query
import Test.Html.Selector as Selector exposing (tag)
import Translations exposing (Lang(En))


suite : Test
suite =
    let
        language =
            Lang.fuzzer

        key =
            "1"
    in
        describe "view"
            [ noRespondentsTest language key
            , oneRespondentTest language key
            , allRespondentsDisplayableTest language key
            , truncatedRespondentsOneExtraTest language key
            , truncatedRespondentsMultipleExtraTest language key
            ]


noRespondentsTest : Fuzzer Lang -> String -> Test
noRespondentsTest language key =
    let
        histogram =
            Dict.fromList
                [ ( key, [] ) ]

        noRespondents =
            Selector.attribute
                (Attributes.attribute
                    "data-name"
                    "survey-response-tooltip-no-respondents"
                )
    in
        describe "when response has no respondents"
            [ fuzz language "displays a specific message for no respondents" <|
                \language ->
                    histogram
                        |> Tooltip.view language key
                        |> Html.Styled.toUnstyled
                        |> Query.fromHtml
                        |> Query.has [ tag "span", noRespondents ]
            ]


oneRespondentTest : Fuzzer Lang -> String -> Test
oneRespondentTest language key =
    let
        histogram =
            Dict.fromList
                [ ( key, [ 1 ] ) ]

        oneRespondent =
            Selector.attribute
                (Attributes.attribute
                    "data-name"
                    "survey-response-tooltip-one-respondent"
                )
    in
        describe "when response has one respondent"
            [ fuzz language "displays a specific message for one respondent" <|
                \language ->
                    histogram
                        |> Tooltip.view language key
                        |> Html.Styled.toUnstyled
                        |> Query.fromHtml
                        |> Query.has [ tag "span", oneRespondent ]
            ]


allRespondentsDisplayableTest : Fuzzer Lang -> String -> Test
allRespondentsDisplayableTest language key =
    let
        histogram =
            Dict.fromList
                [ ( key, [ 1, 2, 3, 4, 5 ] ) ]

        allRespondents =
            Selector.attribute
                (Attributes.attribute
                    "data-name"
                    "survey-response-tooltip-all-respondents"
                )
    in
        describe "when all respondents are displayable in tooltip"
            [ fuzz language "displays all respondents" <|
                \language ->
                    histogram
                        |> Tooltip.view language key
                        |> Html.Styled.toUnstyled
                        |> Query.fromHtml
                        |> Query.has [ tag "span", allRespondents ]
            ]


truncatedRespondentsOneExtraTest : Fuzzer Lang -> String -> Test
truncatedRespondentsOneExtraTest language key =
    let
        histogram =
            Dict.fromList
                [ ( key, [ 1, 2, 3, 4, 5, 6 ] ) ]

        truncatedRespondents =
            Selector.attribute
                (Attributes.attribute
                    "data-name"
                    "survey-response-tooltip-one-truncated-respondent"
                )
    in
        describe "when one respondent is not displayable in tooltip"
            [ fuzz language "truncates respondents list" <|
                \language ->
                    histogram
                        |> Tooltip.view language key
                        |> Html.Styled.toUnstyled
                        |> Query.fromHtml
                        |> Query.has [ tag "span", truncatedRespondents ]
            ]


truncatedRespondentsMultipleExtraTest : Fuzzer Lang -> String -> Test
truncatedRespondentsMultipleExtraTest language key =
    let
        histogram =
            Dict.fromList
                [ ( key, [ 1, 2, 3, 4, 5, 6, 7 ] ) ]

        truncatedRespondents =
            Selector.attribute
                (Attributes.attribute
                    "data-name"
                    "survey-response-tooltip-multiple-truncated-respondents"
                )
    in
        describe "when multiple respondents are not displayable in tooltip"
            [ fuzz language "truncates respondents list" <|
                \language ->
                    histogram
                        |> Tooltip.view language key
                        |> Html.Styled.toUnstyled
                        |> Query.fromHtml
                        |> Query.has [ tag "span", truncatedRespondents ]
            ]
