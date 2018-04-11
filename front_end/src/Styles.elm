module Styles
    exposing
        ( brandBackgroundColor
        , brandBorderColor
        , brandColor
        , brandColorAlpha
        , tooltip
        )

import Css exposing (Color, Style, backgroundColor, color, rgb, rgba)
import Css
    exposing
        ( Color
        , Style
        , absolute
        , after
        , backgroundColor
        , borderColor
        , borderColor4
        , borderStyle
        , borderWidth
        , bottom
        , color
        , hex
        , hidden
        , left
        , pct
        , position
        , property
        , px
        , rgb
        , rgba
        , solid
        , top
        , transparent
        , visibility
        )


brandBackgroundColor : Style
brandBackgroundColor =
    backgroundColor brand


brandBorderColor : Style
brandBorderColor =
    borderColor brand


brandColor : Style
brandColor =
    color brand


brandColorAlpha : Style
brandColorAlpha =
    color brandAlpha


tooltip : Style
tooltip =
    Css.batch
        [ after
            [ borderColor4 (hex "000") transparent transparent transparent
            , borderStyle solid
            , borderWidth (px 5)
            , left (pct 50)
            , position absolute
            , property "content" "''"
            , top (pct 100)
            ]
        , bottom (pct 150)
        , left (pct 25)
        , visibility hidden
        ]


brandAlpha : Color
brandAlpha =
    rgba 252 51 90 0.5


brand : Color
brand =
    rgb 252 51 90
