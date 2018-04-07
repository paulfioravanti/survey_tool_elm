module SurveyResult.View exposing (view)

import Helpers
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
import Html.Events exposing (onWithOptions)
import Json.Decode as Decode
import SurveyResult.Model exposing (SurveyResult)


view : (String -> msg) -> SurveyResult -> Html msg
view msg { name, participantCount, responseRate, submittedResponseCount, url } =
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
            [ "no-underline"
            , "ph0"
            , "pv1"
            ]
                |> String.join " "
    in
        article [ attribute "data-name" "survey-result", class articleClasses ]
            [ a
                [ href (Helpers.toSurveyResultDetailUrl url)
                , class linkClasses
                , onWithOptions
                    "click"
                    { stopPropagation = False
                    , preventDefault = True
                    }
                    (url
                        |> Helpers.extractSurveyResultDetailId
                        |> msg
                        |> Decode.succeed
                    )
                ]
                [ summaryHeading name
                , summaryContent
                    participantCount
                    submittedResponseCount
                    responseRate
                ]
            ]


summaryHeading : String -> Html msg
summaryHeading name =
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
            [ text name ]


summaryContent : Int -> Int -> Float -> Html msg
summaryContent participantCount submittedResponseCount responseRate =
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
                [ statistic "Participants" participantCount
                , statistic "Responses" submittedResponseCount
                ]
            , responseRatePercentage responseRate
            ]


statistic : String -> Int -> Html msg
statistic label value =
    let
        classes =
            [ "b"
            , "flex"
            , "justify-between"
            , "mid-gray"
            ]
                |> String.join " "
    in
        div [ class classes ]
            [ div [ class "f3 f1-ns fw2" ]
                [ text label ]
            , div [ class "f3 f1-ns" ]
                [ text (toString value) ]
            ]


responseRatePercentage : Float -> Html msg
responseRatePercentage responseRate =
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
                [ text (Helpers.toFormattedPercentage responseRate) ]
            ]
