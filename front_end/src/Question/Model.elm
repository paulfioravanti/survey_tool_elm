module Question.Model exposing (Question)

import SurveyResponse exposing (SurveyResponse)


type alias Question =
    { description : String
    , surveyResponses : List SurveyResponse
    , questionType : String
    }
