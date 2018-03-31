module SurveyResult.Model exposing (SurveyResult)


type alias SurveyResult =
    { name : String
    , participantCount : Int
    , responseRate : Float
    , submittedResponseCount : Int
    , url : String
    }
