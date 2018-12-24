module SurveyResponse.Decoder exposing (decoder)

{-| Decodes a JSON survey response.
-}

import Json.Decode as Decode exposing (Decoder, int, string)
import Json.Decode.Pipeline exposing (required)
import SurveyResponse.Model exposing (SurveyResponse)


{-| Decodes a specific JSON survey response from a survey result

    import Json.Decode as Decode
    import SurveyResponse exposing (SurveyResponse)

    json : String
    json =
        """
        {
          "response_content": "5",
          "respondent_id": 1,
          "question_id": 1,
          "id": 1
        }
        """

    surveyResponse : SurveyResponse
    surveyResponse =
        { id = 1
        , questionId = 1
        , respondentId = 1
        , responseContent = "5"
        }

    Decode.decodeString decoder json
    --> Ok surveyResponse

-}
decoder : Decoder SurveyResponse
decoder =
    Decode.succeed SurveyResponse
        |> required "id" int
        |> required "question_id" int
        |> required "respondent_id" int
        |> required "response_content" string
