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
    [ "avenir"
    , "dark-gray"
    , "mv3"
    , "ttu"
    ]
        |> String.join " "


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
    [ "center"
    , "mw7"
    ]
        |> String.join " "


surveyResultList : String
surveyResultList =
    [ "flex"
    , "justify-around"
    , "mt1"
    ]
        |> String.join " "
