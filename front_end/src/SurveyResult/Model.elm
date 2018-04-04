module SurveyResult.Model exposing (SurveyResult)

import Theme.Model exposing (Theme)


type alias SurveyResult =
    { name : String
    , participantCount : Int
    , responseRate : Float
    , submittedResponseCount : Int
    , themes : Maybe (List Theme)
    , url : String
    }
