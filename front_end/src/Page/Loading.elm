module Page.Loading exposing (view)

{-| Static content for a Loading page.
-}

import Html.Styled exposing (Html, div, h1, i, main_, section, text)
import Html.Styled.Attributes exposing (attribute, class, css)
import Html.Styled.Keyed as Keyed
import Language exposing (Language)
import Page.Loading.Styles as Styles
import Translations


view : Language -> Html msg
view language =
    main_ []
        [ section
            [ attribute "data-name" "loading-message"
            , class Styles.layout
            ]
            [ Keyed.node "div" [] [ ( "loading-icon", icon ) ]
            , div []
                [ heading language ]
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


heading : Language -> Html msg
heading language =
    h1 [ class Styles.heading ]
        [ text (Translations.loading language) ]
