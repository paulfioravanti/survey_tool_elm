module SurveyResponse.TooltipTest exposing (suite)

import Dict exposing (Dict)
import Expect
import Html.Attributes as Attributes
import Html.Styled
import I18Next
import SurveyResponse.Tooltip as Tooltip
import Test exposing (Test, describe, test)
import Test.Html.Query as Query
import Test.Html.Selector as Selector exposing (tag)


suite : Test
suite =
    describe "view"
        [ noRespondentsTest ()
        , oneRespondentTest ()
        , allRespondentsDisplayableTest ()
        , truncatedRespondentsOneExtraTest ()
        , truncatedRespondentsMultipleExtraTest ()
        ]


noRespondentsTest : () -> Test
noRespondentsTest () =
    let
        histogram =
            Dict.fromList
                [ ( "1", [] ) ]

        noRespondents =
            Selector.attribute
                (Attributes.attribute
                    "data-name"
                    "survey-response-tooltip-no-respondents"
                )

        translations =
            I18Next.initialTranslations
    in
        describe "when response has no respondents"
            [ test "displays a specific message for no respondents" <|
                \() ->
                    histogram
                        |> Tooltip.view translations "1"
                        |> Html.Styled.toUnstyled
                        |> Query.fromHtml
                        |> Query.has [ tag "span", noRespondents ]
            ]


oneRespondentTest : () -> Test
oneRespondentTest () =
    let
        histogram =
            Dict.fromList
                [ ( "1", [ 1 ] ) ]

        oneRespondent =
            Selector.attribute
                (Attributes.attribute
                    "data-name"
                    "survey-response-tooltip-one-respondent"
                )

        translations =
            I18Next.initialTranslations
    in
        describe "when response has one respondent"
            [ test "displays a specific message for one respondent" <|
                \() ->
                    histogram
                        |> Tooltip.view translations "1"
                        |> Html.Styled.toUnstyled
                        |> Query.fromHtml
                        |> Query.has [ tag "span", oneRespondent ]
            ]


allRespondentsDisplayableTest : () -> Test
allRespondentsDisplayableTest () =
    let
        histogram =
            Dict.fromList
                [ ( "1", [ 1, 2, 3, 4, 5 ] ) ]

        allRespondents =
            Selector.attribute
                (Attributes.attribute
                    "data-name"
                    "survey-response-tooltip-all-respondents"
                )

        translations =
            I18Next.initialTranslations
    in
        describe "when all respondents are displayable in tooltip"
            [ test "displays all respondents" <|
                \() ->
                    histogram
                        |> Tooltip.view translations "1"
                        |> Html.Styled.toUnstyled
                        |> Query.fromHtml
                        |> Query.has [ tag "span", allRespondents ]
            ]


truncatedRespondentsOneExtraTest : () -> Test
truncatedRespondentsOneExtraTest () =
    let
        histogram =
            Dict.fromList
                [ ( "1", [ 1, 2, 3, 4, 5, 6 ] ) ]

        truncatedRespondents =
            Selector.attribute
                (Attributes.attribute
                    "data-name"
                    "survey-response-tooltip-one-truncated-respondent"
                )

        translations =
            I18Next.initialTranslations
    in
        describe "when one respondent is not displayable in tooltip"
            [ test "truncates respondents list" <|
                \() ->
                    histogram
                        |> Tooltip.view translations "1"
                        |> Html.Styled.toUnstyled
                        |> Query.fromHtml
                        |> Query.has [ tag "span", truncatedRespondents ]
            ]


truncatedRespondentsMultipleExtraTest : () -> Test
truncatedRespondentsMultipleExtraTest () =
    let
        histogram =
            Dict.fromList
                [ ( "1", [ 1, 2, 3, 4, 5, 6, 7 ] ) ]

        truncatedRespondents =
            Selector.attribute
                (Attributes.attribute
                    "data-name"
                    "survey-response-tooltip-multiple-truncated-respondents"
                )

        translations =
            I18Next.initialTranslations
    in
        describe "when multiple respondents are not displayable in tooltip"
            [ test "truncates respondents list" <|
                \() ->
                    histogram
                        |> Tooltip.view translations "1"
                        |> Html.Styled.toUnstyled
                        |> Query.fromHtml
                        |> Query.has [ tag "span", truncatedRespondents ]
            ]
