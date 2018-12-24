module Page.Loading.Styles exposing
    ( brandColorAlpha
    , heading
    , icon
    , layout
    )

{-| Loading page-specific styling using CSS and Tachyons.
-}

import Css exposing (Style)
import Page.Styles
import Styles


brandColorAlpha : Style
brandColorAlpha =
    Styles.brandColorAlpha


heading : String
heading =
    Page.Styles.heading


icon : String
icon =
    -- NOTE: fa-prefixed classes are from Font Awesome.
    [ "fa-4x"
    , "fa-pulse"
    , "fa-spinner"
    , "fas"
    ]
        |> String.join " "


layout : String
layout =
    Page.Styles.layout
