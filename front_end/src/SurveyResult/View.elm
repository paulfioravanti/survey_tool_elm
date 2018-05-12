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
import Json.Decode as Decode
import Styles
import SurveyResult.Model exposing (SurveyResult)
import SurveyResult.Utils
import Translations exposing (Lang)
import Utils


view : (String -> msg) -> Lang -> SurveyResult -> Html msg
view surveyResultDetailMsg language surveyResult =
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
                |> class
    in
        article [ classes, css [ Styles.surveyResultSummary ] ]
            [ summaryLink surveyResultDetailMsg language surveyResult ]


summaryLink : (String -> msg) -> Lang -> SurveyResult -> Html msg
summaryLink surveyResultDetailMsg language surveyResult =
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
                |> class

        clickOptions =
            onWithOptions
                "click"
                { preventDefault = True, stopPropagation = False }
                (url
                    |> SurveyResult.Utils.extractId
                    |> surveyResultDetailMsg
                    |> Decode.succeed
                )
    in
        a
            [ href url, classes, clickOptions ]
            [ summaryHeading surveyResult.name
            , summaryContent
                language
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
                |> class
    in
        h1 [ attribute "data-name" "summary-heading", classes ]
            [ text name ]


summaryContent : Lang -> Int -> Int -> Float -> Html msg
summaryContent language participantCount submittedResponseCount responseRate =
    let
        classes =
            [ "flex"
            , "flex-column flex-row-ns"
            , "justify-around"
            , "ph4 ph0-ns"
            ]
                |> String.join " "
                |> class
    in
        div [ classes ]
            [ statistics language participantCount submittedResponseCount
            , responseRatePercentage
                (Translations.responseRate language)
                responseRate
            ]


statistics : Lang -> Int -> Int -> Html msg
statistics language participantCount submittedResponseCount =
    let
        classes =
            [ "w-50-ns" ]
                |> String.join " "
                |> class
    in
        div [ classes ]
            [ statistic
                (Translations.participants language)
                participantCount
            , statistic
                (Translations.responses language)
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
                |> class
    in
        div [ classes ]
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
                |> class
    in
        div [ classes ]
            [ text label ]


statisticValue : Int -> Html msg
statisticValue value =
    let
        classes =
            [ "f3 f1-ns" ]
                |> String.join " "
                |> class
    in
        div [ classes ]
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
            , "w-100 w-50-ns"
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
                |> class
    in
        div [ classes ]
            [ text label ]


responseRateValue : Float -> Html msg
responseRateValue responseRate =
    let
        classes =
            [ "bg-light-gray"
            , "f1-ns"
            , "mh3-ns"
            ]
                |> String.join " "
                |> class

        responsePercentage =
            responseRate
                |> Utils.toFormattedPercentage
    in
        div [ attribute "data-name" "response-rate-value", classes ]
            [ text responsePercentage ]
