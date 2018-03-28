module SurveyResult.Decoder exposing (decoder)

import Json.Decode as Decode exposing (field, float, int, string)
import Json.Decode.Extra exposing ((|:))
import SurveyResult.Model exposing (SurveyResult)


decoder : Decode.Decoder SurveyResult
decoder =
    Decode.succeed
        SurveyResult
        |: (field "name" string)
        |: (field "participant_count" int)
        |: (field "response_rate" float)
        |: (field "submitted_response_count" int)
        |: (field "url" string)
