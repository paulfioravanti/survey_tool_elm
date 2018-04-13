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
        [ describe "when response has no respondents"
            [ test "displays a specific message for no respondents" <|
                \() ->
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
                        histogram
                            |> Tooltip.view "1"
                            |> Html.Styled.toUnstyled
                            |> Query.fromHtml
                            |> Query.has [ tag "span", noRespondents ]
            , test "displays a specific message for one respondent" <|
                \() ->
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
                        histogram
                            |> Tooltip.view "1"
                            |> Html.Styled.toUnstyled
                            |> Query.fromHtml
                            |> Query.has [ tag "span", oneRespondent ]
            , test "displays all respondents when they are all displayable" <|
                \() ->
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
                        histogram
                            |> Tooltip.view "1"
                            |> Html.Styled.toUnstyled
                            |> Query.fromHtml
                            |> Query.has [ tag "span", allRespondents ]
            , test "truncates respondents when they are not all displayable" <|
                \() ->
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
                        histogram
                            |> Tooltip.view "1"
                            |> Html.Styled.toUnstyled
                            |> Query.fromHtml
                            |> Query.has [ tag "span", truncatedRespondents ]
            ]
        ]
