module SurveyResult.Detail.Styles exposing
    ( article
    , brandColor
    , footerContent
    , footerLink
    , footerLogo
    , surveyName
    , surveyNameHeading
    , surveyResultsLink
    , surveyResultsLinkIcon
    )

{-| Styling for the SurveyResult detail page using CSS and Tachyons.
-}

import Css exposing (Style)
import Styles


article : String
article =
    String.join " "
        [ "center"
        , "flex"
        , "flex-column"
        , "mw7-ns"
        ]


brandColor : Style
brandColor =
    Styles.brandColor


footerContent : String
footerContent =
    String.join " "
        [ "b--dotted"
        , "b--light-gray"
        , "bb-0"
        , "bl-0"
        , "br-0"
        , "bt"
        , "center"
        , "mt4"
        , "mw7"
        , "tc"
        ]


footerLink : String
footerLink =
    "dim"


footerLogo : String
footerLogo =
    String.join " "
        [ "h3 h4-ns"
        , "img"
        , "mh0 mh2-ns"
        , "mt0 mv3-ns"
        ]


surveyName : String
surveyName =
    String.join " "
        [ "center"
        , "flex"
        , "flex-row"
        ]


surveyNameHeading : String
surveyNameHeading =
    String.join " "
        [ "avenir"
        , "f2 f1-ns"
        , "mid-gray"
        , "mw5 mw7-ns"
        , "tc"
        ]


surveyResultsLink : String
surveyResultsLink =
    String.join " "
        [ "absolute"
        , "dim"
        , "ml2 ml0-ns"
        , "mt3 mt4-ns"
        , "pt2 pt1-ns"
        ]


surveyResultsLinkIcon : String
surveyResultsLinkIcon =
    -- NOTE: fa-prefixed classes are from Font Awesome.
    String.join " "
        [ "f2 f1-ns"
        , "fa-angle-left"
        , "fas"
        ]
