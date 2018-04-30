module SurveyResultDetail.View exposing (view)

{-| Display a survey result's detail page.
-}

import Html.Styled
    exposing
        ( Attribute
        , Html
        , a
        , article
        , div
        , footer
        , h1
        , i
        , img
        , main_
        , nav
        , text
        )
import Html.Styled.Attributes
    exposing
        ( alt
        , attribute
        , class
        , css
        , href
        , src
        )
import Html.Styled.Events exposing (onWithOptions)
import I18Next exposing (Translations)
import Json.Decode as Decode
import Locale
import Styles
import SurveyResult exposing (SurveyResult)
import SurveyResultDetail.Config exposing (Config)
import SurveyResultDetail.Context exposing (Context)
import Theme
import Utils


view : Config msg -> Context -> SurveyResult -> Html msg
view ({ backToHomeMsg, blurMsg, backToHomePath } as config) context surveyResult =
    let
        classes =
            [ "center"
            , "flex flex-column"
            , "mw7-ns"
            ]
                |> String.join " "
                |> class

        backtoHomeClickOptions =
            msgClickOptions config.backToHomeMsg

        blurClickOptions =
            msgClickOptions config.blurMsg
    in
        main_ []
            [ header config context
            , article
                [ attribute "data-name" "survey-result-detail"
                , classes
                , blurClickOptions
                ]
                [ backToHomeLink backToHomePath backtoHomeClickOptions
                , surveyName surveyResult.name
                , summary context.locale.translations surveyResult
                , div [ attribute "data-name" "themes" ]
                    (List.map
                        (Theme.view config context.locale.translations)
                        (Maybe.withDefault [] surveyResult.themes)
                    )
                ]
            , footerContent backToHomePath backtoHomeClickOptions
            ]


header : Config msg -> Context -> Html msg
header config context =
    let
        dropdownConfig =
            { localeMsg = config.localeMsg }
    in
        nav [ class "flex flex-row-reverse mw8 center mt1" ]
            [ Locale.dropdown dropdownConfig context ]


backToHomeLink : String -> Attribute msg -> Html msg
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
                |> class

        -- NOTE: fa-prefixed classes are from Font Awesome.
        iconClasses =
            [ "fa-angle-left"
            , "fas"
            , "f2 f1-ns"
            ]
                |> String.join " "
                |> class
    in
        a [ href path, classes, clickOptions ]
            [ i [ iconClasses, css [ Styles.brandColor ] ] [] ]


surveyName : String -> Html msg
surveyName name =
    let
        classes =
            [ "center"
            , "flex"
            , "flex-row"
            ]
                |> String.join " "
                |> class

        headingClasses =
            [ "avenir"
            , "f2 f1-ns"
            , "mid-gray"
            , "mw5 mw7-ns"
            , "tc"
            ]
                |> String.join " "
                |> class
    in
        div [ classes ]
            [ h1 [ headingClasses ]
                [ text name ]
            ]


summary : Translations -> SurveyResult -> Html msg
summary translations surveyResult =
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
            [ participationCount
                (I18Next.t translations "participants")
                surveyResult.participantCount
            , submittedResponseCount
                (I18Next.t translations "responses")
                surveyResult.submittedResponseCount
            , submittedResponseRate
                (I18Next.t translations "responseRate")
                surveyResult.responseRate
            ]


participationCount : String -> Int -> Html msg
participationCount label participantCount =
    let
        labelClasses =
            [ "f4 f3-ns"
            , "fw2"
            ]
                |> String.join " "

        valueClasses =
            [ "f4 f3-ns"
            , "fw8"
            , "tc"
            ]
                |> String.join " "
    in
        div [ attribute "data-name" "participation-count" ]
            [ div [ class labelClasses ]
                [ text label ]
            , div [ class valueClasses ]
                [ text (toString participantCount) ]
            ]


submittedResponseCount : String -> Int -> Html msg
submittedResponseCount label responseCount =
    let
        labelClasses =
            [ "f4 f3-ns"
            , "fw2"
            ]
                |> String.join " "

        valueClasses =
            [ "f4 f3-ns"
            , "fw8"
            , "tc"
            ]
                |> String.join " "
    in
        div [ attribute "data-name" "submitted-response-count" ]
            [ div [ class labelClasses ]
                [ text label ]
            , div [ class valueClasses ]
                [ text (toString responseCount) ]
            ]


submittedResponseRate : String -> Float -> Html msg
submittedResponseRate label responseRate =
    let
        labelClasses =
            [ "f4 f3-ns"
            , "fw2"
            ]
                |> String.join " "

        valueClasses =
            [ "f4 f3-ns"
            , "fw8"
            , "tc"
            ]
                |> String.join " "
    in
        div [ attribute "data-name" "submitted-response-rate" ]
            [ div [ class labelClasses ]
                [ text label ]
            , div [ class valueClasses ]
                [ text (Utils.toFormattedPercentage responseRate) ]
            ]


footerContent : String -> Attribute msg -> Html msg
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
                |> class
    in
        footer [ classes ]
            [ a [ href path, class "dim", clickOptions ]
                [ footerLogo ]
            ]


footerLogo : Html msg
footerLogo =
    let
        classes =
            [ "h3 h4-ns"
            , "img"
            , "mh0 mh2-ns"
            , "mt0 mv3-ns"
            ]
                |> String.join " "
                |> class
    in
        img [ src "/logo.png", classes, alt "logo" ] []


msgClickOptions : msg -> Attribute msg
msgClickOptions msg =
    onWithOptions
        "click"
        { preventDefault = True, stopPropagation = True }
        (Decode.succeed msg)
