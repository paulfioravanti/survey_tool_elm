module Message.NotFound exposing (view)

import Html.Styled exposing (Html, a, div, h1, i, main_, section, text)
import Html.Styled.Attributes exposing (attribute, class, css, href)
import Html.Styled.Events exposing (onWithOptions)
import Html.Styled.Keyed as Keyed
import Json.Decode as Decode
import Styles


view : msg -> String -> Html msg
view msg path =
    let
        classes =
            [ "flex"
            , "flex-column"
            , "justify-center"
            , "items-center"
            , "vh-75"
            ]
                |> String.join " "
    in
        main_ []
            [ section
                [ attribute "data-name" "not-found-message", class classes ]
                [ Keyed.node "div" [] [ ( "not-found-icon", icon ) ]
                , div []
                    [ heading ]
                , backToHomeLink msg path
                ]
            ]


icon : Html msg
icon =
    let
        -- NOTE: fa-prefixed classes are from Font Awesome.
        classes =
            [ "fa-4x"
            , "fa-meh"
            , "far"
            ]
                |> String.join " "
    in
        i [ class classes, css [ Styles.brandColorAlpha ] ] []


heading : Html msg
heading =
    let
        classes =
            [ "avenir"
            , "f2 f1-ns"
            , "light-silver"
            , "mv2"
            , "ttu"
            ]
                |> String.join " "
    in
        h1 [ class classes ]
            [ text "Not Found" ]


backToHomeLink : msg -> String -> Html msg
backToHomeLink msg path =
    let
        classes =
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
            , class classes
            , onWithOptions
                "click"
                { preventDefault = True
                , stopPropagation = False
                }
                (Decode.succeed msg)
            ]
            [ text "←  Back to survey results" ]
