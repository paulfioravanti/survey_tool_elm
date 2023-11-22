module SurveyResultList.Decoder exposing (decoder)

import Json.Decode as Decode exposing (Decoder, list)
import Json.Decode.Pipeline exposing (required)
import SurveyResult exposing (SurveyResult)
import SurveyResultList.Model exposing (SurveyResultList)


{-| Decodes a JSON survey result list.

    import Json.Decode as Decode
    import SurveyResult.Model exposing (SurveyResult)
    import SurveyResultList exposing (SurveyResultList)

    json : String
    json =
        """
        {
          "survey_results": [
            {
              "url": "/survey_results/1.json",
              "submitted_response_count": 5,
              "response_rate": 0.8333333333333334,
              "participant_count": 6,
              "name": "Simple Survey"
            }
          ]
        }
        """

    surveyResultList : SurveyResultList
    surveyResultList =
        { surveyResults =
            [ { name = "Simple Survey"
              , participantCount = 6
              , responseRate = 0.8333333333333334
              , submittedResponseCount = 5
              , themes = Nothing
              , url = "/survey_results/1.json"
              }
            ]
        }

    Decode.decodeString decoder json
    --> Ok surveyResultList

-}
decoder : Decoder SurveyResultList
decoder =
    let
        surveyResult : Decoder SurveyResult
        surveyResult =
            SurveyResult.decoder
    in
    Decode.succeed SurveyResultList
        |> required "survey_results" (list surveyResult)
