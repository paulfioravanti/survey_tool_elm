module Message.Error exposing (view)

import Html exposing (Html, div, h1, i, section, text)
import Html.Attributes exposing (attribute, class)
import Html.Keyed as Keyed


view : String -> Html msg
view message =
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
                    [ heading message ]
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


heading : String -> Html msg
heading message =
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
            , div [ class "f6 tc" ]
                [ text ("(" ++ message ++ ")")
                ]
            ]
