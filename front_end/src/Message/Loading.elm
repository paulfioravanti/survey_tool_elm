module Message.Loading exposing (view)

import Html exposing (Html, div, h1, i, main_, section, text)
import Html.Attributes exposing (attribute, class)
import Html.Keyed as Keyed


view : Html msg
view =
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
            [ section [ attribute "data-name" "loading-message" ]
                [ div [ class messageClasses ]
                    [ Keyed.node "div" [] [ ( "loading-icon", icon ) ]
                    , div []
                        [ heading ]
                    ]
                ]
            ]


icon : Html msg
icon =
    let
        -- NOTE: fa-prefixed classes are from Font Awesome.
        iconClasses =
            [ "brand-50"
            , "fa-4x"
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
            , "light-silver"
            , "mv2"
            , "ttu"
            ]
                |> String.join " "
    in
        h1 [ class headingClasses ]
            [ text "Loading" ]
