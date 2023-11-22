module Page.NotFound.Styles exposing
    ( backToHomeLink
    , brandColorAlpha
    , heading
    , icon
    , layout
    )

{-| Not Found page-specific styling using CSS and Tachyons.
-}

import Css exposing (Style)
import Page.Styles
import Styles


backToHomeLink : String
backToHomeLink =
    String.join " "
        [ "avenir"
        , "f5"
        , "hover-gray"
        , "light-silver"
        , "link"
        ]


brandColorAlpha : Style
brandColorAlpha =
    Styles.brandColorAlpha


heading : String
heading =
    Page.Styles.heading


icon : String
icon =
    -- NOTE: fa-prefixed classes are from Font Awesome.
    String.join " "
        [ "fa-4x"
        , "fa-meh"
        , "far"
        ]


layout : String
layout =
    Page.Styles.layout
