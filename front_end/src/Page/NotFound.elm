module Page.NotFound exposing (title, view)

{-| Static content and title for a Not Found page.
-}

import Html.Styled exposing (Html, a, div, h1, i, main_, section, text)
import Html.Styled.Attributes exposing (attribute, class, css, href)
import Html.Styled.Keyed as Keyed
import Language exposing (Language)
import Page.NotFound.Styles as Styles
import SurveyResultList
import Translations


title : Language -> String
title language =
    Translations.notFound language


view : Language -> Html msg
view language =
    main_ []
        [ section
            [ attribute "data-name" "not-found-message"
            , class Styles.layout
            ]
            [ Keyed.node "div" [] [ ( "not-found-icon", icon ) ]
            , heading language
            , backToSurveyResultsListLink language
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
    div []
        [ h1 [ class Styles.heading ]
            [ text (Translations.notFound language) ]
        ]


backToSurveyResultsListLink : Language -> Html msg
backToSurveyResultsListLink language =
    a
        [ href SurveyResultList.path
        , class Styles.backToHomeLink
        ]
        [ text (Translations.backToSurveyResults language) ]
