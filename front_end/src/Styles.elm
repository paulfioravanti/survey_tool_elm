module Styles
    exposing
        ( brandBackgroundColor
        , brandBorderColor
        , brandColor
        , brandColorAlpha
        , overlineText
        , surveyResultSummary
        , tooltip
        )

import Css
    exposing
        ( Color
        , Style
        , absolute
        , active
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
        , hover
        , left
        , overline
        , pct
        , position
        , property
        , px
        , rgb
        , rgba
        , solid
        , textDecoration
        , top
        , transparent
        , visibility
        )
import Css.Foreign exposing (descendants)


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


overlineText : Style
overlineText =
    textDecoration overline


surveyResultSummary : Style
surveyResultSummary =
    let
        styleHeadingAndResponseRate =
            Css.batch
                [ descendants
                    [ Css.Foreign.class "summary-heading"
                        [ brandColor ]
                    , Css.Foreign.class "response-rate-value"
                        [ brandBackgroundColor ]
                    ]
                ]
    in
        Css.batch
            [ hover [ styleHeadingAndResponseRate ]
            , active [ styleHeadingAndResponseRate ]
            ]


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
