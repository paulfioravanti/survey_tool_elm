module SurveyResultDetail.Decoder exposing (decoder)

import Json.Decode as Decode
import SurveyResult.Decoder
import SurveyResult.Model exposing (SurveyResult)


{-| Decodes a JSON survey result with details.

    import Json.Decode as Decode
    import SurveyResult.Model exposing (SurveyResult)

    json : String
    json =
        """
        {
          "survey_result_detail": {
            "url": "/survey_results/1.json",
            "themes": [
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
            ],
            "submitted_response_count": 5,
            "response_rate": 0.8333333333333334,
            "participant_count": 6,
            "name": "Simple Survey"

          }
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
        surveyResult =
            SurveyResult.Decoder.decoder
    in
        surveyResult
            |> Decode.at [ "survey_result_detail" ]
