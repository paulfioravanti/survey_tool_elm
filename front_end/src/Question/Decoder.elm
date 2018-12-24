module Question.Decoder exposing (decoder)

{-| Decodes a JSON survey question.
-}

import Json.Decode as Decode exposing (Decoder, list, string)
import Json.Decode.Pipeline exposing (required)
import Question.Model exposing (Question)
import SurveyResponse


{-| Decodes a JSON question from a survey result

    import Json.Decode as Decode
    import Question exposing (Question)
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
        { description = "I like the kind of work I do."
        , questionType = "ratingquestion"
        , surveyResponses =
            [ SurveyResponse 1 1 1 "5" ]
        }

    Decode.decodeString decoder json
    --> Ok question

-}
decoder : Decoder Question
decoder =
    let
        surveyResponse =
            SurveyResponse.decoder
    in
    Decode.succeed Question
        |> required "description" string
        |> required "survey_responses" (list surveyResponse)
        |> required "question_type" string
