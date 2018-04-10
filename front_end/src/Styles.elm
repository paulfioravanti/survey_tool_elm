module Styles exposing (brandBackgroundColor, brandColor, brandColorAlpha)

import Css exposing (Color, Style, backgroundColor, color, rgb, rgba)


brandBackgroundColor : Style
brandBackgroundColor =
    backgroundColor brand


brandColor : Style
brandColor =
    color brand


brandColorAlpha : Style
brandColorAlpha =
    color brandAlpha


brandAlpha : Color
brandAlpha =
    rgba 252 51 90 0.5


brand : Color
brand =
    rgb 252 51 90
