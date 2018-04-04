module Question.Decoder exposing (decoder)

import Json.Decode as Decode exposing (field, list, string)
import Json.Decode.Extra exposing ((|:))
import Question.Model exposing (Question)
import SurveyResponse.Decoder


{-| Decodes a JSON question.
-}
decoder : Decode.Decoder Question
decoder =
    let
        surveyResponse =
            SurveyResponse.Decoder.decoder
    in
        Decode.succeed
            Question
            |: field "description" string
            |: field "survey_responses" (list surveyResponse)
            |: field "question_type" string
