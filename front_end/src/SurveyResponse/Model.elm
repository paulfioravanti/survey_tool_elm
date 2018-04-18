module SurveyResponse.Model exposing (Rating, RespondentId, SurveyResponse)


type alias Rating =
    String


type alias RespondentId =
    Int


type alias SurveyResponse =
    { id : Int
    , questionId : Int
    , respondentId : RespondentId
    , responseContent : Rating
    }
