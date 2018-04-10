module Message.Loading exposing (view)

import Css exposing (..)
import Html.Styled exposing (Html, div, h1, i, main_, section, text)
import Html.Styled.Attributes exposing (attribute, class, css)
import Html.Styled.Keyed as Keyed


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
            [ "fa-4x"
            , "fa-pulse"
            , "fa-spinner"
            , "fas"
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
            [ text "Loading" ]
