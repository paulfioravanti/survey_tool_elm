module Theme.Decoder exposing (decoder)

{-| Decodes a JSON theme.
-}

import Json.Decode as Decode exposing (Decoder, list, string)
import Json.Decode.Pipeline exposing (required)
import Question exposing (Question)
import Theme.Model exposing (Theme)


{-| Decodes a JSON theme from a survey result

    import Json.Decode as Decode
    import Question.Model exposing (Question)
    import SurveyResponse.Model exposing (SurveyResponse)
    import Theme exposing (Theme)

    json : String
    json =
        """
        {
          "questions": [
            {
              "survey_responses": [
                {
                  "response_content": "5",
                  "respondent_id": 1,
                  "question_id": 1,
                  "id": 1
                }
              ],
              "question_type": "ratingquestion",
              "description": "I like the kind of work I do."
            }
          ],
          "name": "The Work"
        }
        """

    theme : Theme
    theme =
        { name = "The Work"
        , questions =
            [ Question
                  "I like the kind of work I do."
                  [ SurveyResponse 1 1 1 "5" ]
                  "ratingquestion"
            ]
        }

    Decode.decodeString decoder json
    --> Ok theme

-}
decoder : Decoder Theme
decoder =
    let
        question : Decoder Question
        question =
            Question.decoder
    in
    Decode.succeed Theme
        |> required "name" string
        |> required "questions" (list question)
