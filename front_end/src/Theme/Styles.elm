module Theme.Styles exposing
    ( averageScore
    , averageScoreLabel
    , averageScoreValue
    , name
    , theme
    )

{-| Styling for a Theme using Tachyons.
-}


averageScore : String
averageScore =
    String.join " "
        [ "b"
        , "f4 f3-ns"
        , "mid-gray"
        ]


averageScoreLabel : String
averageScoreLabel =
    String.join " "
        [ "fw2"
        , "mr2"
        ]


averageScoreValue : String
averageScoreValue =
    "dark-gray"


theme : String
theme =
    String.join " "
        [ "b--light-gray"
        , "bb"
        , "flex"
        , "flex-row"
        , "justify-between"
        , "mb3"
        , "mh1 mh0-ns"
        , "mt4"
        ]


name : String
name =
    String.join " "
        [ "f4 f3-ns"
        , "mid-gray"
        , "ttu"
        ]
