module SurveyResult.View exposing (view)

import Html
    exposing
        ( Html
        , a
        , article
        , div
        , h1
        , h2
        , img
        , p
        , section
        , span
        , text
        )
import Html.Attributes exposing (attribute, class, href)


view : String -> String -> String -> String -> Html msg
view title numParticipants numResponses responseRatePercentage =
    let
        articleClasses =
            [ "avenir"
            , "b--black-10"
            , "ba"
            , "grow grow:active grow:focus"
            , "hover-bg-washed-red"
            , "ma2 mt2-ns"
            , "pa2"
            ]
                |> String.join " "

        linkClasses =
            [ "no-underline", "ph0", "pv1" ]
                |> String.join " "
    in
        article [ class articleClasses ]
            [ a
                [ attribute "data-name" "survey-link"
                , class linkClasses
                , href "#"
                ]
                [ summaryHeading title
                , summaryContent
                    numParticipants
                    numResponses
                    responseRatePercentage
                ]
            ]


summaryHeading : String -> Html msg
summaryHeading title =
    let
        headingClasses =
            [ "f3 f1-ns"
            , "hover-brand"
            , "light-silver"
            , "mb2"
            , "mt0"
            , "tc"
            ]
                |> String.join " "
    in
        h1 [ class headingClasses ]
            [ text title ]


summaryContent : String -> String -> String -> Html msg
summaryContent numParticipants numResponses responseRatePercentage =
    let
        contentClasses =
            [ "flex"
            , "flex-column flex-row-ns"
            , "justify-around"
            , "ph4 ph0-ns"
            ]
                |> String.join " "
    in
        div [ class contentClasses ]
            [ div [ class "w-50-ns" ]
                [ statistic "Participants" numParticipants
                , statistic "Responses" numResponses
                ]
            , responseRate responseRatePercentage
            ]


statistic : String -> String -> Html msg
statistic label value =
    div [ class "b flex justify-between mid-gray" ]
        [ div [ class "f3 f1-ns fw2" ]
            [ text label ]
        , div [ class "f3 f1-ns" ]
            [ text value ]
        ]


responseRate : String -> Html msg
responseRate responseRatePercentage =
    let
        responseRateClasses =
            [ "b"
            , "dark-gray"
            , "f3"
            , "flex"
            , "flex-column-ns"
            , "justify-between"
            , "mt2 mt0-ns"
            , "tc"
            ]
                |> String.join " "
    in
        div [ class responseRateClasses ]
            [ div [ class "f2-ns fw3 ttu" ]
                [ text "Response Rate" ]
            , div [ class "bg-light-gray f1-ns hover-bg-brand" ]
                [ text responseRatePercentage ]
            ]
