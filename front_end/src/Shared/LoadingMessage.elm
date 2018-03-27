module Shared.LoadingMessage exposing (view)

import Html exposing (Html, div, h1, i, section, text)
import Html.Attributes exposing (attribute, class)


view : Html msg
view =
    let
        messageClasses =
            [ "flex"
            , "flex-column"
            , "justify-center"
            , "items-center"
            , "light-silver"
            , "vh-75"
            ]
                |> String.join " "
    in
        section [ attribute "data-name" "loading-message" ]
            [ div [ class messageClasses ]
                [ div [ class "" ]
                    [ icon ]
                , div [ class "" ]
                    [ heading ]
                ]
            ]


icon : Html msg
icon =
    let
        -- NOTE: fa-prefixed classes are from Font Awesome.
        -- The rest are from Tachyons.
        iconClasses =
            [ "fa-2x"
            , "fa-pulse"
            , "fa-spinner"
            , "fas"
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
            , "mv2"
            , "ttu"
            ]
                |> String.join " "
    in
        h1 [ class headingClasses ]
            [ text "Loading" ]
