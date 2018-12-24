module Question.Styles exposing
    ( averageScore
    , averageScoreLabel
    , descriptionText
    , overlineText
    , question
    , responses
    , scores
    )

{-| Question styling using CSS and Tachyons.
-}

import Css exposing (Style, overline, textDecoration)


averageScore : String
averageScore =
    [ "fw5"
    , "mt2 mt3-ns"
    , "tr"
    ]
        |> String.join " "


averageScoreLabel : String
averageScoreLabel =
    [ "fw1"
    , "i"
    , "mr2"
    , "times"
    ]
        |> String.join " "


descriptionText : String
descriptionText =
    [ "fw4"
    , "w-70-ns"
    ]
        |> String.join " "


overlineText : Style
overlineText =
    textDecoration overline


question : String
question =
    [ "flex"
    , "flex-column flex-row-ns"
    , "justify-between-ns"
    , "mh1 mh0-ns"
    , "mv2"
    ]
        |> String.join " "


responses : String
responses =
    [ "flex"
    , "flex-row"
    , "mr3 mr0-ns"
    ]
        |> String.join " "


scores : String
scores =
    [ "flex"
    , "flex-row-reverse flex-column-ns"
    , "justify-between-ns"
    ]
        |> String.join " "
