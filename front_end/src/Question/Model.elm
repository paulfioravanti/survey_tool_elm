module Question.Model exposing (Question)

import SurveyResponse.Model exposing (SurveyResponse)


type alias Question =
    { description : String
    , surveyResponses : List SurveyResponse
    , questionType : String
    }
