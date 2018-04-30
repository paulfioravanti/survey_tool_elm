module Message.Loading exposing (view)

{-| Displays a loading message while information is being retrieved
from an API endpoint.
-}

import Html.Styled exposing (Html, div, h1, i, main_, section, text)
import Html.Styled.Attributes exposing (attribute, class, css)
import Html.Styled.Keyed as Keyed
import I18Next exposing (Translations)
import Styles


view : Translations -> Html msg
view translations =
    let
        classes =
            [ "flex"
            , "flex-column"
            , "items-center"
            , "justify-center"
            , "vh-75"
            ]
                |> String.join " "
                |> class
    in
        main_ []
            [ section [ attribute "data-name" "loading-message", classes ]
                [ Keyed.node "div" [] [ ( "loading-icon", icon ) ]
                , div []
                    [ heading (I18Next.t translations "loading") ]
                ]
            ]


icon : Html msg
icon =
    let
        -- NOTE: fa-prefixed classes are from Font Awesome.
        classes =
            [ "fa-4x"
            , "fa-pulse"
            , "fa-spinner"
            , "fas"
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
