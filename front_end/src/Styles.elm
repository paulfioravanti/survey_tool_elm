module Styles
    exposing
        ( brandBackgroundColor
        , brandBackgroundColorAlpha
        , brandBorderColor
        , brandColor
        , brandColorAlpha
        , dropdownMenu
        , dropdownMenuCaret
        , dropdownMenuList
        , dropdownMenuListItem
        , overlineText
        , surveyResponse
        , surveyResponseContent
        , surveyResultSummary
        , tooltip
        )

{-| Elm replacement for a CSS stylesheet of re-usable styles.
-}

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
        , marginTop
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
        , visible
        )
import Css.Foreign exposing (children, descendants)


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


dropdownMenu : Style
dropdownMenu =
    hover
        [ Css.Foreign.children
            [ Css.Foreign.selector
                "[data-name='locale-dropdown-current-selection']"
                [ borderColor (rgba 0 0 0 0.1) ]
            ]
        , Css.Foreign.descendants
            [ Css.Foreign.selector
                "[data-name='locale-dropdown-caret']"
                [ color (rgba 0 0 0 0.2) ]
            ]
        ]


dropdownMenuCaret : Style
dropdownMenuCaret =
    left (pct 80)


dropdownMenuList : Style
dropdownMenuList =
    marginTop (Css.rem 0.12)


dropdownMenuListItem : Style
dropdownMenuListItem =
    hover [ brandBackgroundColorAlpha ]


overlineText : Style
overlineText =
    textDecoration overline


surveyResponse : Style
surveyResponse =
    hover
        [ children
            [ Css.Foreign.selector
                "[data-name='survey-response-content']"
                [ brandBackgroundColor ]
            ]
        ]


surveyResponseContent : Style
surveyResponseContent =
    hover
        [ brandBorderColor
        , children
            [ Css.Foreign.selector
                "[data-name*='survey-response-tooltip']"
                [ visibility visible ]
            ]
        ]


surveyResultSummary : Style
surveyResultSummary =
    let
        styleHeadingAndResponseRate =
            Css.batch
                [ descendants
                    [ Css.Foreign.selector "[data-name='summary-heading']"
                        [ brandColor ]
                    , Css.Foreign.selector "[data-name='response-rate-value']"
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
