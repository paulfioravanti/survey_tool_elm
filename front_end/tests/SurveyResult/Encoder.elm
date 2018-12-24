module SurveyResult.Encoder exposing (encode)

import Json.Encode as Encode
import SurveyResult exposing (SurveyResult)


encode : SurveyResult -> Encode.Value
encode surveyResult =
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
        , ( "themes"
          , Encode.null
          )
        , ( "url"
          , Encode.string surveyResult.url
          )
        ]
