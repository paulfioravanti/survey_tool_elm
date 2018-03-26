module SurveyResult.Model exposing (SurveyResult)


type alias SurveyResult =
    { name : String
    , participationCount : Int
    , responseRate : Float
    , submittedResponseCount : Int
    , url : String
    }
