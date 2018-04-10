module Message.NotFound exposing (view)

import Css exposing (..)
import Html.Styled exposing (Html, a, div, h1, i, main_, section, text)
import Html.Styled.Attributes exposing (attribute, class, css, href)
import Html.Styled.Events exposing (onWithOptions)
import Html.Styled.Keyed as Keyed
import Json.Decode as Decode


view : msg -> String -> Html msg
view msg path =
    let
        messageClasses =
            [ "flex"
            , "flex-column"
            , "justify-center"
            , "items-center"
            , "vh-75"
            ]
                |> String.join " "
    in
        main_ []
            [ section [ attribute "data-name" "not-found-message" ]
                [ div [ class messageClasses ]
                    [ Keyed.node "div" [] [ ( "not-found-icon", icon ) ]
                    , div []
                        [ heading ]
                    , backToHomeLink msg path
                    ]
                ]
            ]


icon : Html msg
icon =
    let
        -- NOTE: fa-prefixed classes are from Font Awesome.
        iconClasses =
            [ "fa-4x"
            , "fa-meh"
            , "far"
            ]
                |> String.join " "
    in
        i
            [ class iconClasses
            , css [ color (rgba 252 51 90 0.5) ]
            ]
            []


heading : Html msg
heading =
    let
        headingClasses =
            [ "avenir"
            , "f2 f1-ns"
            , "light-silver"
            , "mv2"
            , "ttu"
            ]
                |> String.join " "
    in
        h1 [ class headingClasses ]
            [ text "Not Found" ]


backToHomeLink : msg -> String -> Html msg
backToHomeLink msg path =
    let
        linkClasses =
            [ "avenir"
            , "f5"
            , "hover-gray"
            , "light-silver"
            , "link"
            ]
                |> String.join " "
    in
        a
            [ href path
            , class linkClasses
            , onWithOptions
                "click"
                { stopPropagation = False
                , preventDefault = True
                }
                (Decode.succeed msg)
            ]
            [ text "←  Back to survey results" ]
