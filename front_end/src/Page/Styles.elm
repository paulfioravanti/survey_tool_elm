module Page.Styles exposing (heading, layout)

{-| Shared styles for static pages.
-}


heading : String
heading =
    [ "avenir"
    , "f2 f1-ns"
    , "light-silver"
    , "mv2"
    , "ttu"
    ]
        |> String.join " "


layout : String
layout =
    [ "flex"
    , "flex-column"
    , "items-center"
    , "justify-center"
    , "tc"
    , "vh-75"
    ]
        |> String.join " "
