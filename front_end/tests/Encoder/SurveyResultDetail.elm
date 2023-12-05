module Encoder.SurveyResultDetail exposing (encode)

import Encoder.Theme as Theme
import Json.Encode as Encode exposing (Value)
import SurveyResult exposing (SurveyResult)


encode : SurveyResult -> Value
encode surveyResult =
    let
        themesEncoder : Value
        themesEncoder =
            case surveyResult.themes of
                Just themes ->
                    Encode.list Theme.encode themes

                Nothing ->
                    Encode.null
    in
    Encode.object
        [ ( "survey_result_detail"
          , Encode.object
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
                  , themesEncoder
                  )
                , ( "url"
                  , Encode.string surveyResult.url
                  )
                ]
          )
        ]
