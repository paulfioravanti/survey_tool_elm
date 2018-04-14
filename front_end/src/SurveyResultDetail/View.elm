module SurveyResultDetail.View exposing (view)

import Html.Styled
    exposing
        ( Html
        , a
        , article
        , div
        , footer
        , h1
        , i
        , img
        , main_
        , text
        )
import Html.Styled.Attributes exposing (alt, attribute, class, css, href, src)
import Html.Styled.Events exposing (onWithOptions)
import Json.Decode as Decode
import Styles
import SurveyResult.Model exposing (SurveyResult)
import Theme.View
import Utils


view : msg -> String -> SurveyResult -> Html msg
view msg path surveyResult =
    let
        classes =
            [ "center"
            , "flex flex-column"
            , "mw7"
            ]
                |> String.join " "

        clickOptions =
            onWithOptions
                "click"
                { preventDefault = True, stopPropagation = False }
                (Decode.succeed msg)
    in
        main_ []
            [ article
                [ attribute "data-name" "survey-result-detail", class classes ]
                [ backToHomeLink path clickOptions
                , surveyName surveyResult.name
                , summary surveyResult
                , div [ attribute "data-name" "themes" ]
                    (List.map
                        Theme.View.view
                        (Maybe.withDefault [] surveyResult.themes)
                    )
                ]
            , footerContent path clickOptions
            ]


backToHomeLink : String -> Html.Styled.Attribute msg -> Html msg
backToHomeLink path clickOptions =
    let
        classes =
            [ "absolute"
            , "dim"
            , "mt4"
            ]
                |> String.join " "

        -- NOTE: fa-prefixed classes are from Font Awesome.
        iconClasses =
            [ "fa-angle-left"
            , "fas"
            , "f1"
            ]
                |> String.join " "
    in
        a [ href path, class classes, clickOptions ]
            [ i [ class iconClasses, css [ Styles.brandColor ] ] [] ]


surveyName : String -> Html msg
surveyName name =
    let
        classes =
            [ "center"
            , "flex"
            , "flex-row"
            ]
                |> String.join " "

        headingClasses =
            [ "avenir"
            , "f1"
            , "mid-gray"
            , "tc"
            ]
                |> String.join " "
    in
        div [ class classes ]
            [ h1 [ class headingClasses ]
                [ text name ]
            ]


summary : SurveyResult -> Html msg
summary surveyResult =
    let
        classes =
            [ "bg-light-gray"
            , "br3"
            , "flex"
            , "flex-row"
            , "justify-between"
            , "mv2"
            , "pa2"
            ]
                |> String.join " "
    in
        div [ class classes ]
            [ participationCount surveyResult.participantCount
            , submittedResponseCount surveyResult.submittedResponseCount
            , submittedResponseRate surveyResult.responseRate
            ]


participationCount : Int -> Html msg
participationCount participantCount =
    let
        labelClasses =
            [ "f3"
            , "fw2"
            ]
                |> String.join " "

        valueClasses =
            [ "b"
            , "f3"
            , "tc"
            ]
                |> String.join " "
    in
        div [ attribute "data-name" "participation-count" ]
            [ div [ class labelClasses ]
                [ text "Participants" ]
            , div [ class valueClasses ]
                [ text (toString participantCount) ]
            ]


submittedResponseCount : Int -> Html msg
submittedResponseCount responseCount =
    let
        labelClasses =
            [ "f3"
            , "fw2"
            ]
                |> String.join " "

        valueClasses =
            [ "b"
            , "f3"
            , "tc"
            ]
                |> String.join " "
    in
        div [ attribute "data-name" "submitted-response-count" ]
            [ div [ class labelClasses ]
                [ text "Responses" ]
            , div [ class valueClasses ]
                [ text (toString responseCount) ]
            ]


submittedResponseRate : Float -> Html msg
submittedResponseRate responseRate =
    let
        labelClasses =
            [ "f3"
            , "fw2"
            ]
                |> String.join " "

        valueClasses =
            [ "b"
            , "f3"
            , "tc"
            ]
                |> String.join " "
    in
        div [ attribute "data-name" "submitted-response-rate" ]
            [ div [ class labelClasses ]
                [ text "Response Rate" ]
            , div [ class valueClasses ]
                [ text (Utils.toFormattedPercentage responseRate) ]
            ]


footerContent : String -> Html.Styled.Attribute msg -> Html msg
footerContent path clickOptions =
    let
        classes =
            [ "b--dotted"
            , "b--light-gray"
            , "bb-0"
            , "bl-0"
            , "br-0"
            , "bt"
            , "center"
            , "mt4"
            , "mw7"
            , "tc"
            ]
                |> String.join " "
    in
        footer [ class classes ]
            [ a [ href path, class "dim", clickOptions ]
                [ logo ]
            ]


logo : Html msg
logo =
    let
        classes =
            [ "h2 h4-ns"
            , "img"
            , "mh0 mh2-ns"
            , "mt0 mv3-ns"
            ]
                |> String.join " "
    in
        img [ src "/logo.png", class classes, alt "logo" ] []
