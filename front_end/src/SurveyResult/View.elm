module SurveyResult.View exposing (view)

import Css exposing (hover)
import Css.Foreign exposing (descendants)
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
        articleTachyons =
            [ "avenir"
            , "b--black-10"
            , "ba"
            , "grow grow:active grow:focus"
            , "hover-bg-washed-red"
            , "ma2 mt2-ns"
            , "pa2"
            ]
                |> String.join " "

        articleCss =
            hover
                [ descendants
                    [ Css.Foreign.class "hover-bg-brand"
                        [ Styles.brandBackgroundColor ]
                    , Css.Foreign.class "hover-brand"
                        [ Styles.brandColor ]
                    ]
                ]
    in
        article [ class articleTachyons, css [ articleCss ] ]
            [ summaryLink msg surveyResult ]


summaryLink : (String -> msg) -> SurveyResult -> Html msg
summaryLink msg surveyResult =
    let
        linkTachyons =
            [ "no-underline"
            , "ph0"
            , "pv1"
            ]
                |> String.join " "
    in
        a
            [ href (SurveyResult.Utils.toDetailUrl surveyResult.url)
            , class linkTachyons
            , onWithOptions
                "click"
                { stopPropagation = False
                , preventDefault = True
                }
                (surveyResult.url
                    |> SurveyResult.Utils.extractId
                    |> msg
                    |> Decode.succeed
                )
            ]
            [ summaryHeading surveyResult.name
            , summaryContent
                surveyResult.participantCount
                surveyResult.submittedResponseCount
                surveyResult.responseRate
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

        percentageClasses =
            [ "bg-light-gray"
            , "f1-ns"
            ]
                |> String.join " "
    in
        div [ class responseRateClasses ]
            [ div [ class "f2-ns fw3 ttu" ]
                [ text "Response Rate" ]
            , div [ class percentageClasses, class "hover-bg-brand" ]
                [ text (Utils.toFormattedPercentage responseRate) ]
            ]
