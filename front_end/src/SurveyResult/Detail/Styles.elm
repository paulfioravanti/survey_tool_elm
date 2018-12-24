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
    [ "center"
    , "flex"
    , "flex-column"
    , "mw7-ns"
    ]
        |> String.join " "


brandColor : Style
brandColor =
    Styles.brandColor


footerContent : String
footerContent =
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
        |> String.join " "


footerLink : String
footerLink =
    "dim"


footerLogo : String
footerLogo =
    [ "h3 h4-ns"
    , "img"
    , "mh0 mh2-ns"
    , "mt0 mv3-ns"
    ]
        |> String.join " "


surveyName : String
surveyName =
    [ "center"
    , "flex"
    , "flex-row"
    ]
        |> String.join " "


surveyNameHeading : String
surveyNameHeading =
    [ "avenir"
    , "f2 f1-ns"
    , "mid-gray"
    , "mw5 mw7-ns"
    , "tc"
    ]
        |> String.join " "


surveyResultsLink : String
surveyResultsLink =
    [ "absolute"
    , "dim"
    , "ml2 ml0-ns"
    , "mt3 mt4-ns"
    , "pt2 pt1-ns"
    ]
        |> String.join " "


surveyResultsLinkIcon : String
surveyResultsLinkIcon =
    -- NOTE: fa-prefixed classes are from Font Awesome.
    [ "f2 f1-ns"
    , "fa-angle-left"
    , "fas"
    ]
        |> String.join " "
