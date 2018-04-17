module Question.Decoder exposing (decoder)

{-| Decodes a JSON survey question.
-}

import Json.Decode as Decode exposing (field, list, string)
import Json.Decode.Extra exposing ((|:))
import Question.Model exposing (Question)
import SurveyResponse.Decoder


{-| Decodes a JSON question from a survey result

    import Json.Decode as Decode
    import Question.Model exposing (Question)
    import SurveyResponse.Model exposing (SurveyResponse)

    json : String
    json =
        """
        {
          "description": "I like the kind of work I do.",
          "question_type": "ratingquestion",
          "survey_responses": [
            {
              "response_content": "5",
              "respondent_id": 1,
              "question_id": 1,
              "id": 1
            }
          ]
        }
        """

    question : Question
    question =
        Question
           "I like the kind of work I do."
           [ SurveyResponse 1 1 1 "5" ]
           "ratingquestion"

    Decode.decodeString decoder json
    --> Ok question

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
