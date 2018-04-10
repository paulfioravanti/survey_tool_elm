module Styles exposing (brandBackgroundColor, brandColor)

import Css exposing (Color, Style, backgroundColor, color, rgb)


brandBackgroundColor : Style
brandBackgroundColor =
    backgroundColor brand


brandColor : Style
brandColor =
    color brand


brand : Color
brand =
    rgb 252 51 90
