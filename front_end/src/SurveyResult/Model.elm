module SurveyResult.Model exposing (SurveyResult)


type alias SurveyResult =
    { name : String
    , participationCount : String
    , responseRate : String
    , submittedResponseCount : String
    , url : String
    }
