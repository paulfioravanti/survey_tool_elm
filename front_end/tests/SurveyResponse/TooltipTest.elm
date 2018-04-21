module SurveyResponse.TooltipTest exposing (suite)

import Dict exposing (Dict)
import Expect
import Html.Attributes as Attributes
import Html.Styled
import I18Next exposing (Translations)
import SurveyResponse.Tooltip as Tooltip
import Test exposing (Test, describe, test)
import Test.Html.Query as Query
import Test.Html.Selector as Selector exposing (tag)


suite : Test
suite =
    let
        translations =
            I18Next.initialTranslations

        key =
            "1"
    in
        describe "view"
            [ noRespondentsTest translations key
            , oneRespondentTest translations key
            , allRespondentsDisplayableTest translations key
            , truncatedRespondentsOneExtraTest translations key
            , truncatedRespondentsMultipleExtraTest translations key
            ]


noRespondentsTest : Translations -> String -> Test
noRespondentsTest translations key =
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
            [ test "displays a specific message for no respondents" <|
                \() ->
                    histogram
                        |> Tooltip.view translations key
                        |> Html.Styled.toUnstyled
                        |> Query.fromHtml
                        |> Query.has [ tag "span", noRespondents ]
            ]


oneRespondentTest : Translations -> String -> Test
oneRespondentTest translations key =
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
            [ test "displays a specific message for one respondent" <|
                \() ->
                    histogram
                        |> Tooltip.view translations key
                        |> Html.Styled.toUnstyled
                        |> Query.fromHtml
                        |> Query.has [ tag "span", oneRespondent ]
            ]


allRespondentsDisplayableTest : Translations -> String -> Test
allRespondentsDisplayableTest translations key =
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
            [ test "displays all respondents" <|
                \() ->
                    histogram
                        |> Tooltip.view translations key
                        |> Html.Styled.toUnstyled
                        |> Query.fromHtml
                        |> Query.has [ tag "span", allRespondents ]
            ]


truncatedRespondentsOneExtraTest : Translations -> String -> Test
truncatedRespondentsOneExtraTest translations key =
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
            [ test "truncates respondents list" <|
                \() ->
                    histogram
                        |> Tooltip.view translations key
                        |> Html.Styled.toUnstyled
                        |> Query.fromHtml
                        |> Query.has [ tag "span", truncatedRespondents ]
            ]


truncatedRespondentsMultipleExtraTest : Translations -> String -> Test
truncatedRespondentsMultipleExtraTest translations key =
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
            [ test "truncates respondents list" <|
                \() ->
                    histogram
                        |> Tooltip.view translations key
                        |> Html.Styled.toUnstyled
                        |> Query.fromHtml
                        |> Query.has [ tag "span", truncatedRespondents ]
            ]
