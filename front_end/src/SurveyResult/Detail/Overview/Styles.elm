module SurveyResult.Detail.Overview.Styles exposing (label, summary, value)

{-| Overview styling for the SurveyResult detail page using Tachyons.
-}


label : String
label =
    [ "f4 f3-ns"
    , "fw2"
    ]
        |> String.join " "


summary : String
summary =
    [ "bg-light-gray"
    , "br3-ns"
    , "flex"
    , "flex-row"
    , "justify-between"
    , "mv2"
    , "pa2"
    , "tc"
    ]
        |> String.join " "


value : String
value =
    [ "f4 f3-ns"
    , "fw8"
    , "tc"
    ]
        |> String.join " "
