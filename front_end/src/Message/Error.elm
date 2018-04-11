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
            [ section [ attribute "data-name" "error-message", class classes ]
                [ Keyed.node "div" [] [ ( "error-icon", icon ) ]
                , div []
                    [ errorContent error ]
                ]
            ]


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


errorContent : Http.Error -> Html msg
errorContent error =
    let
        classes =
            [ "avenir"
            , "light-silver"
            , "mv2"
            ]
                |> String.join " "
    in
        h1 [ class classes ]
            [ errorHeading
            , errorMessage error
            ]


errorHeading : Html msg
errorHeading =
    let
        classes =
            [ "f2 f1-ns"
            , "ttu"
            ]
                |> String.join " "
    in
        div [ class classes ]
            [ text "Error retrieving data" ]


errorMessage : Http.Error -> Html msg
errorMessage error =
    let
        ( name, message ) =
            errorToMessage error

        classes =
            [ "f6"
            , "tc"
            ]
                |> String.join " "
    in
        div [ attribute "data-name" name, class classes ]
            [ text ("(" ++ message ++ ")") ]


errorToMessage : Http.Error -> ( String, String )
errorToMessage error =
    case error of
        Http.NetworkError ->
            ( "network-error-message", "Is the server running?" )

        Http.BadStatus response ->
            ( "bad-status-message", toString response.status.message )

        Http.BadPayload message response ->
            ( "bad-payload-message", "Decoding Failed: " ++ message )

        _ ->
            ( "other-error-message", toString error )
