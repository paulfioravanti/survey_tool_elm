module SurveyResponse.Decoder exposing (decoder)

{-| Decodes a JSON survey response.
-}

import Json.Decode as Decode exposing (field, int, string)
import Json.Decode.Extra exposing ((|:))
import SurveyResponse.Model exposing (SurveyResponse)


{-| Decodes a JSON survey response from a survey result

    import Json.Decode as Decode
    import SurveyResponse.Model exposing (SurveyResponse)

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
        SurveyResponse 1 1 1 "5"

    Decode.decodeString decoder json
    --> Ok surveyResponse

-}
decoder : Decode.Decoder SurveyResponse
decoder =
    Decode.succeed
        SurveyResponse
        |: field "id" int
        |: field "question_id" int
        |: field "respondent_id" int
        |: field "response_content" string
