module SurveyResponse.Decoder exposing (decoder)

import Json.Decode as Decode exposing (field, int, string)
import Json.Decode.Extra exposing ((|:))
import SurveyResponse.Model exposing (SurveyResponse)


{-| Decodes a JSON survey response.
-}
decoder : Decode.Decoder SurveyResponse
decoder =
    Decode.succeed
        SurveyResponse
        |: field "id" int
        |: field "question_id" int
        |: field "respondent_id" int
        |: field "response_content" string
