module Message.Error exposing (view)

import Html.Styled exposing (Html, div, h1, i, main_, section, text)
import Html.Styled.Attributes exposing (attribute, class, css)
import Html.Styled.Keyed as Keyed
import Http
import Styles


view : Http.Error -> Html msg
view error =
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
            [ section [ class classes ]
                [ Keyed.node "div" [] [ ( "error-icon", icon ) ]
                , div []
                    [ heading (errorToMessage error) ]
                ]
            ]


errorToMessage : Http.Error -> String
errorToMessage error =
    case error of
        Http.NetworkError ->
            "Is the server running?"

        Http.BadStatus response ->
            toString response.status.message

        Http.BadPayload message response ->
            "Decoding Failed: " ++ message

        _ ->
            toString error


icon : Html msg
icon =
    let
        -- NOTE: fa-prefixed classes are from Font Awesome.
        classes =
            [ "fa-4x"
            , "fa-frown"
            , "far"
            ]
                |> String.join " "
    in
        i [ class classes, css [ Styles.brandColorAlpha ] ] []


heading : String -> Html msg
heading message =
    let
        headingClasses =
            [ "avenir"
            , "light-silver"
            , "mv2"
            ]
                |> String.join " "

        headingTextClasses =
            [ "f2 f1-ns"
            , "ttu"
            ]
                |> String.join " "

        errorMessageClasses =
            [ "f6"
            , "tc"
            ]
                |> String.join " "
    in
        h1 [ class headingClasses ]
            [ div [ class headingTextClasses ]
                [ text "Error retrieving data" ]
            , div [ class errorMessageClasses ]
                [ text ("(" ++ message ++ ")") ]
            ]
