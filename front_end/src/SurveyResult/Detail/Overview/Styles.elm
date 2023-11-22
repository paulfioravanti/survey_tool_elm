module SurveyResult.Detail.Overview.Styles exposing (label, summary, value)

{-| Overview styling for the SurveyResult detail page using Tachyons.
-}


label : String
label =
    String.join " "
        [ "f4 f3-ns"
        , "fw2"
        ]


summary : String
summary =
    String.join " "
        [ "bg-light-gray"
        , "br3-ns"
        , "flex"
        , "flex-row"
        , "justify-between"
        , "mv2"
        , "pa2"
        , "tc"
        ]


value : String
value =
    String.join " "
        [ "f4 f3-ns"
        , "fw8"
        , "tc"
        ]
