module SurveyResult.Decoder exposing (decoder)

import Json.Decode as Decode exposing (field, float, int, string)
import Json.Decode.Extra exposing ((|:))
import SurveyResult.Model exposing (SurveyResult)


{-| Decodes a JSON survey result.

    import Json.Decode
    import SurveyResult.Model exposing (SurveyResult)

    json : String
    json =
        """
        {
          "url": "/survey_results/1.json",
          "submitted_response_count": 5,
          "response_rate": 0.8333333333333334,
          "participant_count": 6,
          "name": "Simple Survey"
        }
        """

    surveyResult : SurveyResult
    surveyResult =
        SurveyResult
            "Simple Survey"
            6
            0.8333333333333334
            5
            "/survey_results/1.json"

    Json.Decode.decodeString decoder json
    --> Ok surveyResult

-}
decoder : Decode.Decoder SurveyResult
decoder =
    Decode.succeed
        SurveyResult
        |: (field "name" string)
        |: (field "participant_count" int)
        |: (field "response_rate" float)
        |: (field "submitted_response_count" int)
        |: (field "url" string)
