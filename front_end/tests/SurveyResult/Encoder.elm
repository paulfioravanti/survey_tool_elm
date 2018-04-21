module SurveyResult.Encoder exposing (encoder)

import Json.Encode as Encode
import SurveyResult exposing (SurveyResult)


encoder : SurveyResult -> Encode.Value
encoder surveyResult =
    Encode.object
        [ ( "name"
          , Encode.string surveyResult.name
          )
        , ( "participant_count"
          , Encode.int surveyResult.participantCount
          )
        , ( "response_rate"
          , Encode.float surveyResult.responseRate
          )
        , ( "submitted_response_count"
          , Encode.int surveyResult.submittedResponseCount
          )
        , ( "url"
          , Encode.string surveyResult.url
          )
        ]
