module SurveyResponse.TooltipTest exposing (suite)

import Dict exposing (Dict)
import Expect
import Html.Attributes as Attributes
import Html.Styled
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
        , truncatedRespondentsTest ()
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
    in
        describe "when response has no respondents"
            [ test "displays a specific message for no respondents" <|
                \() ->
                    histogram
                        |> Tooltip.view "1"
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
    in
        describe "when response has one respondent"
            [ test "displays a specific message for one respondent" <|
                \() ->
                    histogram
                        |> Tooltip.view "1"
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
    in
        describe "when all respondents are displayable in tooltip"
            [ test "displays all respondents" <|
                \() ->
                    histogram
                        |> Tooltip.view "1"
                        |> Html.Styled.toUnstyled
                        |> Query.fromHtml
                        |> Query.has [ tag "span", allRespondents ]
            ]


truncatedRespondentsTest : () -> Test
truncatedRespondentsTest () =
    let
        histogram =
            Dict.fromList
                [ ( "1", [ 1, 2, 3, 4, 5, 6 ] ) ]

        truncatedRespondents =
            Selector.attribute
                (Attributes.attribute
                    "data-name"
                    "survey-response-tooltip-truncated-respondents"
                )
    in
        describe "when all respondents are not displayable in tooltip"
            [ test "truncates respondents list" <|
                \() ->
                    histogram
                        |> Tooltip.view "1"
                        |> Html.Styled.toUnstyled
                        |> Query.fromHtml
                        |> Query.has [ tag "span", truncatedRespondents ]
            ]
