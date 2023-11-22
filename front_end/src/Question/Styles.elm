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
    String.join " "
        [ "fw5"
        , "mt2 mt3-ns"
        , "tr"
        ]


averageScoreLabel : String
averageScoreLabel =
    String.join " "
        [ "fw1"
        , "i"
        , "mr2"
        , "times"
        ]


descriptionText : String
descriptionText =
    String.join " "
        [ "fw4"
        , "w-70-ns"
        ]


overlineText : Style
overlineText =
    textDecoration overline


question : String
question =
    String.join " "
        [ "flex"
        , "flex-column flex-row-ns"
        , "justify-between-ns"
        , "mh1 mh0-ns"
        , "mv2"
        ]


responses : String
responses =
    String.join " "
        [ "flex"
        , "flex-row"
        , "mr3 mr0-ns"
        ]


scores : String
scores =
    String.join " "
        [ "flex"
        , "flex-row-reverse flex-column-ns"
        , "justify-between-ns"
        ]
