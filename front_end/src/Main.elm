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
        [ section [ attribute "data-name" "survey-results", class "mw7 center" ]
            [ h1 [ class "tc ttu f1 f-5-ns mv4 avenir dark-gray" ]
                [ text "Survey Results" ]
            , surveySummary "Simple Survey" "6" "5" "83%"
            , surveySummary "Acme Engagement Survey" "271" "271" "100%"
            ]
        ]


surveySummary : String -> String -> String -> String -> Html msg
surveySummary title numParticipants numResponses responseRatePercentage =
    article [ class "ba b--black-10 ma2 mt2-ns grow grow:focus grow:active avenir hover-bg-washed-red" ]
        [ a
            [ class "db pv1 ph0 no-underline black hover-trigger"
            , href "#"
            ]
            [ h1
                [ class "tc f2 f1-ns mt0 mb2 light-silver hover-target hover-brand"
                ]
                [ text title ]
            , div
                [ class "flex flex-column flex-row-ns justify-around ph4 ph0-ns"
                ]
                [ div [ class "w-50-ns" ]
                    [ statistic "Participants" numParticipants
                    , statistic "Responses" numResponses
                    ]
                , responseRate responseRatePercentage
                ]
            ]
        ]


statistic : String -> String -> Html msg
statistic label value =
    div [ class "flex justify-between mid-gray b" ]
        [ div [ class "f2 f1-ns fw2" ]
            [ text label ]
        , div [ class "f2 f1-ns" ]
            [ text value ]
        ]


responseRate : String -> Html msg
responseRate responseRatePercentage =
    div [ class "tc flex flex-column-ns mt2 mt0-ns justify-between dark-gray b" ]
        [ div [ class "f2 ttu fw3" ]
            [ text "Response Rate" ]
        , div [ class "f2 f1-ns bg-light-gray hover-target hover-bg-brand" ]
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
