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
    [ "avenir"
    , "light-silver"
    , "mv2"
    ]
        |> String.join " "


heading : String
heading =
    [ "f2 f1-ns"
    , "ttu"
    ]
        |> String.join " "


icon : String
icon =
    -- NOTE: fa-prefixed classes are from Font Awesome.
    [ "fa-4x"
    , "fa-frown"
    , "far"
    ]
        |> String.join " "


layout : String
layout =
    Page.Styles.layout


message : String
message =
    [ "f6"
    , "tc"
    ]
        |> String.join " "
