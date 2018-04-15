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


view : msg -> msg -> String -> SurveyResult -> Html msg
view surveyResultsListMsg noOpMsg path surveyResult =
    let
        classes =
            [ "center"
            , "flex flex-column"
            , "mw7-ns"
            ]
                |> String.join " "

        surveyResultsListClickOptions =
            msgClickOptions surveyResultsListMsg

        noOpClickOptions =
            msgClickOptions noOpMsg
    in
        main_ [ noOpClickOptions ]
            [ article
                [ attribute "data-name" "survey-result-detail", class classes ]
                [ backToHomeLink path surveyResultsListClickOptions
                , surveyName surveyResult.name
                , summary surveyResult
                , div [ attribute "data-name" "themes" ]
                    (List.map
                        (Theme.View.view)
                        (Maybe.withDefault [] surveyResult.themes)
                    )
                ]
            , footerContent path surveyResultsListClickOptions
            ]


backToHomeLink : String -> Html.Styled.Attribute msg -> Html msg
backToHomeLink path clickOptions =
    let
        classes =
            [ "absolute"
            , "dim"
            , "mt3 mt4-ns"
            , "pt2 pt1-ns"
            , "ml2 ml0-ns"
            ]
                |> String.join " "

        -- NOTE: fa-prefixed classes are from Font Awesome.
        iconClasses =
            [ "fa-angle-left"
            , "fas"
            , "f2 f1-ns"
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
            , "f2 f1-ns"
            , "mid-gray"
            , "mw5 mw7-ns"
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
            , "br3-ns"
            , "flex"
            , "flex-row"
            , "justify-between"
            , "mv2"
            , "pa2"
            , "tc"
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
            [ "f4 f3-ns"
            , "fw2"
            ]
                |> String.join " "

        valueClasses =
            [ "b"
            , "f4 f3-ns"
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
            [ "f4 f3-ns"
            , "fw2"
            ]
                |> String.join " "

        valueClasses =
            [ "b"
            , "f4 f3-ns"
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
            [ "f4 f3-ns"
            , "fw2"
            ]
                |> String.join " "

        valueClasses =
            [ "b"
            , "f4 f3-ns"
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
            [ "h3 h4-ns"
            , "img"
            , "mh0 mh2-ns"
            , "mt0 mv3-ns"
            ]
                |> String.join " "
    in
        img [ src "/logo.png", class classes, alt "logo" ] []


msgClickOptions : msg -> Html.Styled.Attribute msg
msgClickOptions msg =
    onWithOptions
        "click"
        { preventDefault = True, stopPropagation = True }
        (Decode.succeed msg)
