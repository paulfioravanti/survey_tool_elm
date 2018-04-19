module Message.NotFound exposing (view)

{-| Displays a not found message for 404 errors.
-}

import I18Next exposing (Translations)
import Html.Styled exposing (Html, a, div, h1, i, main_, section, text)
import Html.Styled.Attributes exposing (attribute, class, css, href)
import Html.Styled.Events exposing (onWithOptions)
import Html.Styled.Keyed as Keyed
import Json.Decode as Decode
import Styles


view : msg -> String -> Translations -> Html msg
view msg path translations =
    let
        classes =
            [ "flex"
            , "flex-column"
            , "justify-center"
            , "items-center"
            , "vh-75"
            ]
                |> String.join " "
                |> class
    in
        main_ []
            [ section
                [ attribute "data-name" "not-found-message", classes ]
                [ Keyed.node "div" [] [ ( "not-found-icon", icon ) ]
                , div []
                    [ heading (I18Next.t translations "notFound") ]
                , backToHomeLink
                    msg
                    path
                    (I18Next.t translations "backToSurveyResults")
                ]
            ]


icon : Html msg
icon =
    let
        -- NOTE: fa-prefixed classes are from Font Awesome.
        classes =
            [ "fa-4x"
            , "fa-meh"
            , "far"
            ]
                |> String.join " "
                |> class
    in
        i [ classes, css [ Styles.brandColorAlpha ] ] []


heading : String -> Html msg
heading label =
    let
        classes =
            [ "avenir"
            , "f2 f1-ns"
            , "light-silver"
            , "mv2"
            , "ttu"
            ]
                |> String.join " "
                |> class
    in
        h1 [ classes ]
            [ text label ]


backToHomeLink : msg -> String -> String -> Html msg
backToHomeLink msg path label =
    let
        classes =
            [ "avenir"
            , "f5"
            , "hover-gray"
            , "light-silver"
            , "link"
            ]
                |> String.join " "
                |> class
    in
        a
            [ href path
            , classes
            , onWithOptions
                "click"
                { preventDefault = True
                , stopPropagation = False
                }
                (Decode.succeed msg)
            ]
            [ text label ]
