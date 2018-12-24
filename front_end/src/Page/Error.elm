module Page.Error exposing (view)

{-| Static content for a non-404 error page.
-}

import Html.Styled exposing (Html, div, h1, i, main_, section, text)
import Html.Styled.Attributes exposing (attribute, class, css)
import Html.Styled.Keyed as Keyed
import Http exposing (Error)
import Language exposing (Language)
import Page.Error.Styles as Styles
import Translations


view : Language -> Error -> Html msg
view language error =
    main_ []
        [ section
            [ attribute "data-name" "error-message"
            , class Styles.layout
            ]
            [ Keyed.node "div" [] [ ( "error-icon", icon ) ]
            , div []
                [ content language error ]
            ]
        ]



-- PRIVATE


icon : Html msg
icon =
    i
        [ class Styles.icon
        , css [ Styles.brandColorAlpha ]
        ]
        []


content : Language -> Error -> Html msg
content language error =
    h1 [ class Styles.content ]
        [ heading language
        , message language error
        ]


heading : Language -> Html msg
heading language =
    div [ class Styles.heading ]
        [ text (Translations.errorRetrievingData language) ]


message : Language -> Error -> Html msg
message language error =
    let
        ( name, messageContent ) =
            error
                |> errorToMessage language
    in
    div
        [ attribute "data-name" name
        , class Styles.message
        ]
        [ text ("(" ++ messageContent ++ ")") ]


errorToMessage : Language -> Error -> ( String, String )
errorToMessage language error =
    case error of
        Http.NetworkError ->
            ( "network-error-message"
            , Translations.networkErrorMessage language
            )

        Http.BadStatus 404 ->
            ( "bad-status-message", Translations.notFound language )

        -- Unused variable is `response`
        Http.BadBody debugMessage ->
            ( "bad-body-message"
            , Translations.badBodyMessage language debugMessage
            )

        _ ->
            ( "other-error-message", Translations.otherErrorMessage language )
