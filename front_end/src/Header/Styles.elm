module Header.Styles exposing (layout)

{-| Header-specific styling using Tachyons.
-}


layout : String
layout =
    String.join " "
        [ "center"
        , "flex"
        , "flex-row-reverse"
        , "mt1"
        , "mw8"
        ]
