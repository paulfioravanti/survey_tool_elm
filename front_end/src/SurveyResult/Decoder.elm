module SurveyResult.Decoder exposing (decoder)

{-| Decoder for a JSON survey result.
-}

import Json.Decode as Decode
    exposing
        ( Decoder
        , float
        , int
        , list
        , nullable
        , string
        )
import Json.Decode.Pipeline exposing (optional, required)
import SurveyResult.Model exposing (SurveyResult)
import Theme


{-| Decodes a JSON survey result.

    import Json.Decode as Decode
    import SurveyResult exposing (SurveyResult)

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
        { name = "Simple Survey"
        , participantCount = 6
        , responseRate = 0.8333333333333334
        , submittedResponseCount = 5
        , themes = Nothing
        , url = "/survey_results/1.json"
        }

    Decode.decodeString decoder json
    --> Ok surveyResult

-}
decoder : Decoder SurveyResult
decoder =
    let
        theme =
            Theme.decoder
    in
    Decode.succeed SurveyResult
        |> required "name" string
        |> required "participant_count" int
        |> required "response_rate" float
        |> required "submitted_response_count" int
        |> optional "themes" (nullable (list theme)) Nothing
        |> required "url" string
