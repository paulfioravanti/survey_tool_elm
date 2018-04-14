module SurveyResult.View exposing (view)

import Html.Styled
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
import Html.Styled.Attributes exposing (attribute, class, css, href)
import Html.Styled.Events exposing (onWithOptions)
import Json.Decode as Decode
import Styles
import SurveyResult.Model exposing (SurveyResult)
import SurveyResult.Utils
import Utils


view : (String -> msg) -> SurveyResult -> Html msg
view msg surveyResult =
    let
        classes =
            [ "avenir"
            , "b--black-10"
            , "ba"
            , "grow grow:active grow:focus"
            , "hover-bg-washed-red"
            , "ma2 mt2-ns"
            , "pa2"
            ]
                |> String.join " "
    in
        article [ class classes, css [ Styles.surveyResultSummary ] ]
            [ summaryLink msg surveyResult ]


summaryLink : (String -> msg) -> SurveyResult -> Html msg
summaryLink msg surveyResult =
    let
        url =
            surveyResult.url
                |> SurveyResult.Utils.toDetailUrl

        classes =
            [ "no-underline"
            , "ph0"
            , "pv1"
            ]
                |> String.join " "

        clickOptions =
            onWithOptions
                "click"
                { preventDefault = True, stopPropagation = False }
                (url
                    |> SurveyResult.Utils.extractId
                    |> msg
                    |> Decode.succeed
                )
    in
        a
            [ href url, class classes, clickOptions ]
            [ summaryHeading surveyResult.name
            , summaryContent
                surveyResult.participantCount
                surveyResult.submittedResponseCount
                surveyResult.responseRate
            ]


summaryHeading : String -> Html msg
summaryHeading name =
    let
        classes =
            [ "f3 f1-ns"
            , "light-silver"
            , "mb2"
            , "mt0"
            , "tc"
            ]
                |> String.join " "
    in
        h1 [ class classes, class "summary-heading" ]
            [ text name ]


summaryContent : Int -> Int -> Float -> Html msg
summaryContent participantCount submittedResponseCount responseRate =
    let
        classes =
            [ "flex"
            , "flex-column flex-row-ns"
            , "justify-around"
            , "ph4 ph0-ns"
            ]
                |> String.join " "
    in
        div [ class classes ]
            [ statistics participantCount submittedResponseCount
            , responseRatePercentage responseRate
            ]


statistics : Int -> Int -> Html msg
statistics participantCount submittedResponseCount =
    let
        classes =
            [ "w-50-ns" ]
                |> String.join " "
    in
        div [ class classes ]
            [ statistic "Participants" participantCount
            , statistic "Responses" submittedResponseCount
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
            [ statisticLabel label
            , statisticValue value
            ]


statisticLabel : String -> Html msg
statisticLabel label =
    let
        classes =
            [ "f3 f1-ns"
            , "fw4 fw2-ns"
            ]
                |> String.join " "
    in
        div [ class classes ]
            [ text label ]


statisticValue : Int -> Html msg
statisticValue value =
    let
        classes =
            [ "f3 f1-ns" ]
                |> String.join " "
    in
        div [ class classes ]
            [ text (toString value) ]


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
            [ responseRateLabel
            , responseRateValue responseRate
            ]


responseRateLabel : Html msg
responseRateLabel =
    let
        classes =
            [ "f2-ns"
            , "fw4 fw3-ns"
            , "ttu"
            ]
                |> String.join " "
    in
        div [ class classes ]
            [ text "Response Rate" ]


responseRateValue : Float -> Html msg
responseRateValue responseRate =
    let
        classes =
            [ "bg-light-gray"
            , "f1-ns"
            ]
                |> String.join " "

        responsePercentage =
            responseRate
                |> Utils.toFormattedPercentage
    in
        div [ class classes, class "response-rate-value" ]
            [ text responsePercentage ]
