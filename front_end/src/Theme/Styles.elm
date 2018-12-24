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
    [ "b"
    , "f4 f3-ns"
    , "mid-gray"
    ]
        |> String.join " "


averageScoreLabel : String
averageScoreLabel =
    [ "fw2"
    , "mr2"
    ]
        |> String.join " "


averageScoreValue : String
averageScoreValue =
    "dark-gray"


theme : String
theme =
    [ "b--light-gray"
    , "bb"
    , "flex"
    , "flex-row"
    , "justify-between"
    , "mb3"
    , "mh1 mh0-ns"
    , "mt4"
    ]
        |> String.join " "


name : String
name =
    [ "f4 f3-ns"
    , "mid-gray"
    , "ttu"
    ]
        |> String.join " "
