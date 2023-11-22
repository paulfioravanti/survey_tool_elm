module SurveyResult.Summary.Styles exposing
    ( responseRate
    , responseRateLabel
    , responseRateValue
    , statistic
    , statisticLabel
    , statisticValue
    , statistics
    , summary
    , summaryContent
    , summaryCss
    , summaryHeading
    , summaryLink
    )

{-| Styling for the SurveyResult summary, as seen on the survey result list
page, detail page using CSS and Tachyons.
-}

import Css exposing (Style, active, hover)
import Css.Global as Global
import Styles


responseRate : String
responseRate =
    String.join " "
        [ "b"
        , "dark-gray"
        , "f3"
        , "flex"
        , "flex-column-ns"
        , "justify-between"
        , "mt2 mt0-ns"
        , "tc"
        , "w-100 w-50-ns"
        ]


responseRateLabel : String
responseRateLabel =
    String.join " "
        [ "f2-ns"
        , "fw4 fw3-ns"
        , "ttu"
        ]


responseRateValue : String
responseRateValue =
    String.join " "
        [ "bg-light-gray"
        , "f1-ns"
        , "mh3-ns"
        ]


statistic : String
statistic =
    String.join " "
        [ "b"
        , "flex"
        , "justify-between"
        , "mid-gray"
        ]


statisticLabel : String
statisticLabel =
    String.join " "
        [ "f3 f1-ns"
        , "fw4 fw2-ns"
        ]


statistics : String
statistics =
    "w-50-ns"


statisticValue : String
statisticValue =
    "f3 f1-ns"


summary : String
summary =
    String.join " "
        [ "avenir"
        , "b--black-10"
        , "ba"
        , "grow grow:active grow:focus"
        , "hover-bg-washed-red"
        , "ma2 mt2-ns"
        , "pa2"
        ]


summaryContent : String
summaryContent =
    String.join " "
        [ "flex"
        , "flex-column flex-row-ns"
        , "justify-around"
        , "ph4 ph0-ns"
        ]


summaryCss : Style
summaryCss =
    let
        styleHeadingAndResponseRate : Style
        styleHeadingAndResponseRate =
            Css.batch
                [ Global.descendants
                    [ Global.selector "[data-name='summary-heading']"
                        [ Styles.brandColor ]
                    , Global.selector "[data-name='response-rate-value']"
                        [ Styles.brandBackgroundColor ]
                    ]
                ]
    in
    Css.batch
        [ hover [ styleHeadingAndResponseRate ]
        , active [ styleHeadingAndResponseRate ]
        ]


summaryHeading : String
summaryHeading =
    String.join " "
        [ "f3 f1-ns"
        , "light-silver"
        , "mb2"
        , "mt0"
        , "tc"
        ]


summaryLink : String
summaryLink =
    String.join " "
        [ "no-underline"
        , "ph0"
        , "pv1"
        ]
