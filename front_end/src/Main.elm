module Main exposing (..)

import Html
    exposing
        ( Html
        , a
        , article
        , div
        , h1
        , h2
        , img
        , main_
        , p
        , section
        , span
        , text
        )
import Html.Attributes exposing (alt, attribute, class, href, src)


---- MODEL ----


type alias Model =
    {}


init : ( Model, Cmd Msg )
init =
    ( {}, Cmd.none )



---- UPDATE ----


type Msg
    = NoOp


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    ( model, Cmd.none )



---- VIEW ----


view : Model -> Html Msg
view model =
    main_ []
        [ section
            [ attribute "data-name" "survey-results", class "mw7 center" ]
            [ div [ class "flex justify-around" ]
                [ h1 [ class "ttu f2 f-5-ns mv3 avenir dark-gray" ]
                    [ text "Survey", logo, text "Results" ]
                ]
            , surveySummary "Simple Survey" "6" "5" "83%"
            , surveySummary "Acme Engagement Survey" "271" "271" "100%"
            ]
        ]


logo : Html msg
logo =
    let
        logoClasses =
            [ "h2 h3-ns", "img", "mh0 mh2-ns", "mt0 mt4-ns" ]
                |> String.join " "
    in
        img [ src "/culture-amp.png", class logoClasses, alt "logo" ] []


surveySummary : String -> String -> String -> String -> Html msg
surveySummary title numParticipants numResponses responseRatePercentage =
    let
        articleClasses =
            [ "avenir"
            , "b--black-10"
            , "ba"
            , "grow grow:active grow:focus"
            , "hover-bg-washed-red"
            , "ma2 mt2-ns"
            ]
                |> String.join " "

        linkClasses =
            [ "black", "db", "no-underline", "ph0", "pv1" ]
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
            , "flex-column"
            , "flex-row-ns"
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
    div [ class "flex justify-between mid-gray b" ]
        [ div [ class "f1-ns f3 fw2" ]
            [ text label ]
        , div [ class "f1-ns f3" ]
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
            [ div [ class "f2-ns ttu fw3" ]
                [ text "Response Rate" ]
            , div [ class "bg-light-gray f1-ns hover-bg-brand" ]
                [ text responseRatePercentage ]
            ]



---- PROGRAM ----


main : Program Never Model Msg
main =
    Html.program
        { view = view
        , init = init
        , update = update
        , subscriptions = always Sub.none
        }
