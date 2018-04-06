module Message.Error exposing (view)

import Html exposing (Html, div, h1, i, main_, section, text)
import Html.Attributes exposing (attribute, class)
import Html.Keyed as Keyed
import Http


view : Http.Error -> Html msg
view error =
    let
        taggedMessage =
            errorToMessage error

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
            [ section [ attribute "data-name" "error-message" ]
                [ div [ class messageClasses ]
                    [ Keyed.node "div" [] [ ( "error-icon", icon ) ]
                    , div []
                        [ heading taggedMessage ]
                    ]
                ]
            ]


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
