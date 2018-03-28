module Messages.NotFound exposing (view)

import Html exposing (Html, a, div, h1, i, section, text)
import Html.Attributes exposing (attribute, class, href)
import Html.Events exposing (onClick)
import Html.Keyed as Keyed


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
        section [ attribute "data-name" "not-found-message" ]
            [ div [ class messageClasses ]
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
        iconClasses =
            [ "brand-50"
            , "fa-4x"
            , "fa-meh"
            , "far"
            ]
                |> String.join " "
    in
        i [ class iconClasses ] []


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
            [ text "Page Not Found" ]


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
        a [ href path, class linkClasses, onClick msg ]
            [ text "←  Back to survey results" ]
