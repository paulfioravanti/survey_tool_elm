module SurveyResultDetail.Decoder exposing (decoder)

{-| Decoder for a JSON survey result with extra information required
for the survey result detail pages.
-}

import Json.Decode as Decode
import SurveyResult exposing (SurveyResult)


{-| Decodes a JSON survey result with details.

    import Json.Decode as Decode
    import Question.Model exposing (Question)
    import SurveyResponse.Model exposing (SurveyResponse)
    import SurveyResult exposing (SurveyResult)
    import Theme.Model exposing (Theme)

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
            (Just
                [ Theme
                    "The Work"
                    [ Question
                        "I like the kind of work I do."
                        [ SurveyResponse 1 1 1 "5" ]
                        "ratingquestion"
                    ]
                ]
            )
            "/survey_results/1.json"

    Decode.decodeString decoder json
    --> Ok surveyResult

-}
decoder : Decode.Decoder SurveyResult
decoder =
    let
        surveyResult =
            SurveyResult.decoder
    in
        surveyResult
            |> Decode.at [ "survey_result_detail" ]
