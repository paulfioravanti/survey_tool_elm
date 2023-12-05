module Encoder.Question exposing (encode)

import Encoder.SurveyResponse as SurveyResponse
import Json.Encode as Encode
import Question exposing (Question)


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
