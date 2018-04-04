module SurveyResponse.Model exposing (SurveyResponse)


type alias SurveyResponse =
    { id : Int
    , questionId : Int
    , respondentId : Int
    , responseContent : String
    }
