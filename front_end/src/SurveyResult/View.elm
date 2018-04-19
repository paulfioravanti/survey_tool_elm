module SurveyResult.View exposing (view)

{-| Display for a survey result within a survey result list.
-}

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
import I18Next exposing (Translations)
import Json.Decode as Decode
import Styles
import SurveyResult.Model exposing (SurveyResult)
import SurveyResult.Utils
import Utils


view : (String -> msg) -> Translations -> SurveyResult -> Html msg
view msg translations surveyResult =
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
            [ summaryLink msg translations surveyResult ]


summaryLink : (String -> msg) -> Translations -> SurveyResult -> Html msg
summaryLink msg translations surveyResult =
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
                translations
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


summaryContent : Translations -> Int -> Int -> Float -> Html msg
summaryContent translations participantCount submittedResponseCount responseRate =
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
            [ statistics translations participantCount submittedResponseCount
            , responseRatePercentage
                (I18Next.t translations "responseRate")
                responseRate
            ]


statistics : Translations -> Int -> Int -> Html msg
statistics translations participantCount submittedResponseCount =
    let
        classes =
            [ "w-50-ns" ]
                |> String.join " "
    in
        div [ class classes ]
            [ statistic
                (I18Next.t translations "participants")
                participantCount
            , statistic
                (I18Next.t translations "responses")
                submittedResponseCount
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


responseRatePercentage : String -> Float -> Html msg
responseRatePercentage label responseRate =
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
            [ responseRateLabel label
            , responseRateValue responseRate
            ]


responseRateLabel : String -> Html msg
responseRateLabel label =
    let
        classes =
            [ "f2-ns"
            , "fw4 fw3-ns"
            , "ttu"
            ]
                |> String.join " "
    in
        div [ class classes ]
            [ text label ]


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
