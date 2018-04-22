module SurveyResult.Model exposing (Config, SurveyResult)

import Theme exposing (Theme)


type alias Config msg =
    { surveyResultDetailMsg : String -> msg }


type alias SurveyResult =
    { name : String
    , participantCount : Int
    , responseRate : Float
    , submittedResponseCount : Int
    , themes : Maybe (List Theme)
    , url : String
    }
