module Message.Error exposing (view)

{-| Displays a message for a non-404 error.
-}

import Html.Styled exposing (Html, div, h1, i, main_, section, text)
import Html.Styled.Attributes exposing (attribute, class, css)
import Html.Styled.Keyed as Keyed
import Http
import I18Next exposing (Translations)
import Styles


view : Http.Error -> Translations -> Html msg
view error translations =
    let
        classes =
            [ "flex"
            , "flex-column"
            , "justify-center"
            , "items-center"
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
                    [ errorContent error translations ]
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


errorContent : Http.Error -> Translations -> Html msg
errorContent error translations =
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
            [ errorHeading (I18Next.t translations "errorRetrievingData")
            , errorMessage error translations
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


errorMessage : Http.Error -> Translations -> Html msg
errorMessage error translations =
    let
        ( name, message ) =
            errorToMessage error translations

        classes =
            [ "f6"
            , "tc"
            ]
                |> String.join " "
                |> class
    in
        div [ attribute "data-name" name, classes ]
            [ text ("(" ++ message ++ ")") ]


errorToMessage : Http.Error -> Translations -> ( String, String )
errorToMessage error translations =
    case error of
        Http.NetworkError ->
            ( "network-error-message"
            , I18Next.t translations "networkErrorMessage"
            )

        Http.BadStatus response ->
            ( "bad-status-message", toString response.status.message )

        Http.BadPayload message response ->
            ( "bad-payload-message"
            , I18Next.t translations "badPayloadMessage"
            )

        _ ->
            ( "other-error-message", toString error )
