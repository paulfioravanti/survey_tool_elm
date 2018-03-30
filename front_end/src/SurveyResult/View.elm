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


view : (Int -> msg) -> SurveyResult -> Html msg
view msg surveyResult =
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
                [ href (Helpers.toSurveyResultDetailUrl surveyResult.url)
                , class linkClasses
                , onWithOptions
                    "click"
                    { stopPropagation = False
                    , preventDefault = True
                    }
                    (surveyResult.url
                        |> Helpers.extractSurveyResultDetailId
                        |> msg
                        |> Decode.succeed
                    )
                ]
                [ summaryHeading surveyResult.name
                , summaryContent
                    surveyResult.participationCount
                    surveyResult.submittedResponseCount
                    surveyResult.responseRate
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


summaryContent : Int -> Int -> Float -> Html msg
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


statistic : String -> Int -> Html msg
statistic label value =
    div [ class "b flex justify-between mid-gray" ]
        [ div [ class "f3 f1-ns fw2" ]
            [ text label ]
        , div [ class "f3 f1-ns" ]
            [ text (toString value) ]
        ]


responseRate : Float -> Html msg
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
                [ text (Helpers.toFormattedPercentage responseRatePercentage) ]
            ]
