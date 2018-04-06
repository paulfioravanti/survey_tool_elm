module SurveyResult.Decoder exposing (decoder)

import Json.Decode as Decode exposing (field, float, int, list, maybe, string)
import Json.Decode.Extra exposing ((|:))
import SurveyResult.Model exposing (SurveyResult)
import Theme.Decoder


{-| Decodes a JSON survey result.

    import Json.Decode as Decode
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
            Nothing
            "/survey_results/1.json"

    Decode.decodeString decoder json
    --> Ok surveyResult

-}
decoder : Decode.Decoder SurveyResult
decoder =
    let
        theme =
            Theme.Decoder.decoder
    in
        Decode.succeed
            SurveyResult
            |: field "name" string
            |: field "participant_count" int
            |: field "response_rate" float
            |: field "submitted_response_count" int
            |: maybe (field "themes" (list theme))
            |: field "url" string
