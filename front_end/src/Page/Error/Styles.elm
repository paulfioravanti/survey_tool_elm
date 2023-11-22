module Page.Error.Styles exposing
    ( brandColorAlpha
    , content
    , heading
    , icon
    , layout
    , message
    )

{-| Error page-specific styling using CSS and Tachyons.
-}

import Css exposing (Style)
import Page.Styles
import Styles


brandColorAlpha : Style
brandColorAlpha =
    Styles.brandColorAlpha


content : String
content =
    String.join " "
        [ "avenir"
        , "light-silver"
        , "mv2"
        ]


heading : String
heading =
    String.join " "
        [ "f2 f1-ns"
        , "ttu"
        ]


icon : String
icon =
    -- NOTE: fa-prefixed classes are from Font Awesome.
    String.join " "
        [ "fa-4x"
        , "fa-frown"
        , "far"
        ]


layout : String
layout =
    Page.Styles.layout


message : String
message =
    String.join " "
        [ "f6"
        , "tc"
        ]
