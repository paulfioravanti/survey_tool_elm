module SurveyResult.Detail.Encoder exposing (encode)

import Json.Encode as Encode
import SurveyResult exposing (SurveyResult)
import Theme.Encoder as Theme


encode : SurveyResult -> Encode.Value
encode surveyResult =
    let
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
