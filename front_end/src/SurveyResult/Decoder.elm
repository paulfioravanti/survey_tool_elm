module SurveyResult.Decoder exposing (decoder)

import SurveyResult.Model exposing (SurveyResult)
import Json.Decode as Decode exposing (field, float, int, string)
import Json.Decode.Extra exposing ((|:))


decoder : Decode.Decoder SurveyResult
decoder =
    Decode.succeed
        SurveyResult
        |: (field "name" string)
        |: (field "participation_count" int)
        |: (field "response_rate" float)
        |: (field "submitted_response_count" int)
        |: (field "url" string)
