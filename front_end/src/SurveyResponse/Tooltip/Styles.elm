module SurveyResponse.Tooltip.Styles exposing (tooltip, tooltipCss)

{-| SurveyResponse tooltip-specific styling using CSS and Tachyons.
-}

import Css
    exposing
        ( Style
        , absolute
        , after
        , borderColor4
        , borderStyle
        , borderWidth
        , bottom
        , hex
        , hidden
        , left
        , pct
        , position
        , property
        , px
        , solid
        , top
        , transparent
        , visibility
        )


tooltip : String
tooltip =
    [ "absolute"
    , "avenir"
    , "bg-dark-gray"
    , "br3"
    , "f6"
    , "nl5"
    , "pa1"
    , "tc"
    , "w4"
    , "white"
    , "z-1"
    ]
        |> String.join " "


tooltipCss : Style
tooltipCss =
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
