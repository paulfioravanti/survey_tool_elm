module SurveyResultList.Styles exposing
    ( heading
    , headingCss
    , section
    , surveyResultList
    )

{-| Styling for SurveyResultList using CSS and Tachyons.
-}

import Css exposing (Style, fontSize)
import Css.Media exposing (minWidth, only, screen, withMedia)


heading : String
heading =
    String.join " "
        [ "avenir"
        , "dark-gray"
        , "mv3"
        , "ttu"
        ]


headingCss : Style
headingCss =
    Css.batch
        [ withMedia
            [ only screen [ minWidth (Css.em 30) ] ]
            [ fontSize (Css.rem 4.0) ]
        , fontSize (Css.rem 1.9)
        ]


section : String
section =
    String.join " "
        [ "center"
        , "mw7"
        ]


surveyResultList : String
surveyResultList =
    String.join " "
        [ "flex"
        , "justify-around"
        , "mt1"
        ]
