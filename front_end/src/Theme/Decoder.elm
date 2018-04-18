module Theme.Decoder exposing (decoder)

{-| Decodes a JSON theme.
-}

import Json.Decode as Decode exposing (field, list, string)
import Json.Decode.Extra exposing ((|:))
import Question
import Theme.Model exposing (Theme)


{-| Decodes a JSON theme from a survey result

    import Json.Decode as Decode
    import Question exposing (Question)
    import SurveyResponse.Model exposing (SurveyResponse)
    import Theme.Model exposing (Theme)

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
        Theme
            "The Work"
            [ Question
                  "I like the kind of work I do."
                  [ SurveyResponse 1 1 1 "5" ]
                  "ratingquestion"
            ]

    Decode.decodeString decoder json
    --> Ok theme

-}
decoder : Decode.Decoder Theme
decoder =
    let
        question =
            Question.decoder
    in
        Decode.succeed
            Theme
            |: field "name" string
            |: field "questions" (list question)
