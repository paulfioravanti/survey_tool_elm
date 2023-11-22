module Styles exposing
    ( body
    , brandBackgroundColor
    , brandBackgroundColorAlpha
    , brandBorderColor
    , brandColor
    , brandColorAlpha
    )

{-| Shared application styles in CSS and Tachyons.
-}

import Css
    exposing
        ( Color
        , Style
        , backgroundColor
        , borderColor
        , color
        , rgb
        , rgba
        )


body : String
body =
    String.join " "
        [ "bg-white"
        , "sans-serif"
        , "w-100"
        ]


brandBackgroundColor : Style
brandBackgroundColor =
    backgroundColor brand


brandBackgroundColorAlpha : Style
brandBackgroundColorAlpha =
    backgroundColor brandAlpha


brandBorderColor : Style
brandBorderColor =
    borderColor brand


brandColor : Style
brandColor =
    color brand


brandColorAlpha : Style
brandColorAlpha =
    color brandAlpha



-- PRIVATE


brand : Color
brand =
    rgb 252 51 90


brandAlpha : Color
brandAlpha =
    rgba 252 51 90 0.5
