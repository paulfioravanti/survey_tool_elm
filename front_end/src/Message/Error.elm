module Message.Error exposing (view)

import Html exposing (Html, div, h1, i, section, text)
import Html.Attributes exposing (attribute, class)
import Html.Keyed as Keyed


view : ( String, String ) -> Html msg
view messageTuple =
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
        section [ attribute "data-name" "error-message" ]
            [ div [ class messageClasses ]
                [ Keyed.node "div" [] [ ( "error-icon", icon ) ]
                , div []
                    [ heading messageTuple ]
                ]
            ]


icon : Html msg
icon =
    let
        -- NOTE: fa-prefixed classes are from Font Awesome.
        iconClasses =
            [ "brand-50"
            , "fa-4x"
            , "fa-frown"
            , "far"
            ]
                |> String.join " "
    in
        i [ class iconClasses ] []


heading : ( String, String ) -> Html msg
heading ( attributeName, message ) =
    let
        headingClasses =
            [ "avenir"
            , "light-silver"
            , "mv2"
            ]
                |> String.join " "
    in
        h1 [ class headingClasses ]
            [ div [ class "f2 f1-ns ttu" ]
                [ text "Error retrieving data"
                ]
            , div [ attribute "data-name" attributeName, class "f6 tc" ]
                [ text ("(" ++ message ++ ")")
                ]
            ]
