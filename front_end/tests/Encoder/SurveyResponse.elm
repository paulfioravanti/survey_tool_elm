module Encoder.SurveyResponse exposing (encode)

import Json.Encode as Encode
import SurveyResponse exposing (SurveyResponse)


encode : SurveyResponse -> Encode.Value
encode surveyResponse =
    Encode.object
        [ ( "id"
          , Encode.int surveyResponse.id
          )
        , ( "question_id"
          , Encode.int surveyResponse.questionId
          )
        , ( "respondent_id"
          , Encode.int surveyResponse.respondentId
          )
        , ( "response_content"
          , Encode.string surveyResponse.responseContent
          )
        ]
