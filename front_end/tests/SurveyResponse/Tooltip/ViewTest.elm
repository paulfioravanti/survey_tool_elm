module SurveyResponse.Tooltip.ViewTest exposing (all)

import Dict
import Fuzz exposing (Fuzzer)
import Html.Attributes as Attributes
import Html.Styled as Html exposing (Html)
import Language exposing (Language)
import Language.Fuzzer as Language
import SurveyResponse.RespondentHistogram exposing (RespondentHistogram)
import SurveyResponse.Tooltip.View as Tooltip
import Test exposing (Test, describe, fuzz2)
import Test.Html.Query as Query
import Test.Html.Selector as Selector exposing (Selector, tag)


all : Test
all =
    let
        randomKey : Fuzzer Int
        randomKey =
            Fuzz.int

        randomLanguage : Fuzzer Language
        randomLanguage =
            Language.fuzzer
    in
    describe "SurveyResponse.Tooltip.view"
        [ noRespondentsTest randomKey randomLanguage
        , oneRespondentTest randomKey randomLanguage
        , allRespondentsDisplayableTest randomKey randomLanguage
        , truncatedRespondentsOneExtraTest randomKey randomLanguage
        , truncatedRespondentsMultipleExtraTest randomKey randomLanguage
        ]


noRespondentsTest : Fuzzer Int -> Fuzzer Language -> Test
noRespondentsTest randomKey randomLanguage =
    let
        noRespondents : Selector
        noRespondents =
            Selector.attribute
                (Attributes.attribute
                    "data-name"
                    "survey-response-tooltip-no-respondents"
                )
    in
    describe "when response has no respondents"
        [ fuzz2
            randomKey
            randomLanguage
            "displays a specific message for no respondents"
            (\intKey language ->
                let
                    key : String
                    key =
                        String.fromInt intKey

                    histogram : RespondentHistogram
                    histogram =
                        Dict.fromList
                            [ ( key, [] ) ]

                    html : Html msg
                    html =
                        Tooltip.view language key histogram
                in
                html
                    |> Html.toUnstyled
                    |> Query.fromHtml
                    |> Query.has [ tag "span", noRespondents ]
            )
        ]


oneRespondentTest : Fuzzer Int -> Fuzzer Language -> Test
oneRespondentTest randomKey randomLanguage =
    let
        oneRespondent : Selector
        oneRespondent =
            Selector.attribute
                (Attributes.attribute
                    "data-name"
                    "survey-response-tooltip-one-respondent"
                )
    in
    describe "when response has one respondent"
        [ fuzz2
            randomKey
            randomLanguage
            "displays a specific message for one respondent"
            (\intKey language ->
                let
                    key : String
                    key =
                        String.fromInt intKey

                    histogram : RespondentHistogram
                    histogram =
                        Dict.fromList
                            [ ( key, [ "1" ] ) ]

                    html : Html msg
                    html =
                        Tooltip.view language key histogram
                in
                html
                    |> Html.toUnstyled
                    |> Query.fromHtml
                    |> Query.has [ tag "span", oneRespondent ]
            )
        ]


allRespondentsDisplayableTest : Fuzzer Int -> Fuzzer Language -> Test
allRespondentsDisplayableTest randomKey randomLanguage =
    let
        allRespondents : Selector
        allRespondents =
            Selector.attribute
                (Attributes.attribute
                    "data-name"
                    "survey-response-tooltip-all-respondents"
                )
    in
    describe "when all respondents are displayable in tooltip"
        [ fuzz2 randomKey randomLanguage "displays all respondents" <|
            \intKey language ->
                let
                    key : String
                    key =
                        String.fromInt intKey

                    histogram : RespondentHistogram
                    histogram =
                        Dict.fromList
                            [ ( key, [ "1", "2", "3", "4", "5" ] ) ]

                    html : Html msg
                    html =
                        Tooltip.view language key histogram
                in
                html
                    |> Html.toUnstyled
                    |> Query.fromHtml
                    |> Query.has [ tag "span", allRespondents ]
        ]


truncatedRespondentsOneExtraTest : Fuzzer Int -> Fuzzer Language -> Test
truncatedRespondentsOneExtraTest randomKey randomLanguage =
    let
        truncatedRespondents : Selector
        truncatedRespondents =
            Selector.attribute
                (Attributes.attribute
                    "data-name"
                    "survey-response-tooltip-one-truncated-respondent"
                )
    in
    describe "when one respondent is not displayable in tooltip"
        [ fuzz2 randomKey randomLanguage "truncates respondents list" <|
            \intKey language ->
                let
                    key : String
                    key =
                        String.fromInt intKey

                    histogram : RespondentHistogram
                    histogram =
                        Dict.fromList
                            [ ( key, [ "1", "2", "3", "4", "5", "6" ] ) ]

                    html : Html msg
                    html =
                        Tooltip.view language key histogram
                in
                html
                    |> Html.toUnstyled
                    |> Query.fromHtml
                    |> Query.has [ tag "span", truncatedRespondents ]
        ]


truncatedRespondentsMultipleExtraTest : Fuzzer Int -> Fuzzer Language -> Test
truncatedRespondentsMultipleExtraTest randomKey randomLanguage =
    let
        truncatedRespondents : Selector
        truncatedRespondents =
            Selector.attribute
                (Attributes.attribute
                    "data-name"
                    "survey-response-tooltip-multiple-truncated-respondents"
                )
    in
    describe "when multiple respondents are not displayable in tooltip"
        [ fuzz2 randomKey randomLanguage "truncates respondents list" <|
            \intKey language ->
                let
                    key : String
                    key =
                        String.fromInt intKey

                    histogram : RespondentHistogram
                    histogram =
                        Dict.fromList
                            [ ( key, [ "1", "2", "3", "4", "5", "6", "7" ] ) ]

                    html : Html msg
                    html =
                        Tooltip.view language key histogram
                in
                html
                    |> Html.toUnstyled
                    |> Query.fromHtml
                    |> Query.has [ tag "span", truncatedRespondents ]
        ]
