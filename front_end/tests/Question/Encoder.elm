module Question.Encoder exposing (encode)

import Json.Encode as Encode
import Question exposing (Question)
import SurveyResponse.Encoder as SurveyResponse


encode : Question -> Encode.Value
encode question =
    Encode.object
        [ ( "description"
          , Encode.string question.description
          )
        , ( "survey_responses"
          , Encode.list SurveyResponse.encode question.surveyResponses
          )
        , ( "question_type"
          , Encode.string question.questionType
          )
        ]
