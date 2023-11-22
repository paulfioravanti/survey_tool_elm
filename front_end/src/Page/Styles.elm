module Page.Styles exposing (heading, layout)

{-| Shared styles for static pages.
-}


heading : String
heading =
    String.join " "
        [ "avenir"
        , "f2 f1-ns"
        , "light-silver"
        , "mv2"
        , "ttu"
        ]


layout : String
layout =
    String.join " "
        [ "flex"
        , "flex-column"
        , "items-center"
        , "justify-center"
        , "tc"
        , "vh-75"
        ]
