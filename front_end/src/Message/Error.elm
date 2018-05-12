module Message.Error exposing (view)

{-| Displays a message for a non-404 error.
-}

import Html.Styled exposing (Html, div, h1, i, main_, section, text)
import Html.Styled.Attributes exposing (attribute, class, css)
import Html.Styled.Keyed as Keyed
import Http exposing (Error, Error(BadPayload, BadStatus, NetworkError))
import Styles
import Translations exposing (Lang)


view : Error -> Lang -> Html msg
view error language =
    let
        classes =
            [ "flex"
            , "flex-column"
            , "items-center"
            , "justify-center"
            , "tc"
            , "vh-75"
            ]
                |> String.join " "
                |> class
    in
        main_ []
            [ section [ attribute "data-name" "error-message", classes ]
                [ Keyed.node "div" [] [ ( "error-icon", icon ) ]
                , div []
                    [ errorContent error language ]
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
                |> class
    in
        i [ classes, css [ Styles.brandColorAlpha ] ] []


errorContent : Error -> Lang -> Html msg
errorContent error language =
    let
        classes =
            [ "avenir"
            , "light-silver"
            , "mv2"
            ]
                |> String.join " "
                |> class
    in
        h1 [ classes ]
            [ errorHeading (Translations.errorRetrievingData language)
            , errorMessage error language
            ]


errorHeading : String -> Html msg
errorHeading label =
    let
        classes =
            [ "f2 f1-ns"
            , "ttu"
            ]
                |> String.join " "
                |> class
    in
        div [ classes ]
            [ text label ]


errorMessage : Error -> Lang -> Html msg
errorMessage error language =
    let
        ( name, message ) =
            errorToMessage error language

        classes =
            [ "f6"
            , "tc"
            ]
                |> String.join " "
                |> class
    in
        div [ attribute "data-name" name, classes ]
            [ text ("(" ++ message ++ ")") ]


errorToMessage : Error -> Lang -> ( String, String )
errorToMessage error language =
    case error of
        NetworkError ->
            ( "network-error-message"
            , Translations.networkErrorMessage language
            )

        BadStatus response ->
            ( "bad-status-message", toString response.status.message )

        BadPayload message response ->
            ( "bad-payload-message"
            , Translations.badPayloadMessage language message
            )

        _ ->
            ( "other-error-message", toString error )
