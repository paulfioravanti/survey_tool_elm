module SurveyResultList.Decoder exposing (decoder)

{-| Decoder for a JSON survey result list.
-}

import Json.Decode as Decode exposing (field, list)
import Json.Decode.Extra exposing ((|:))
import SurveyResult.Decoder
import SurveyResultList.Model exposing (SurveyResultList)


{-| Decodes a JSON survey result list.

    import Json.Decode
    import SurveyResult exposing (SurveyResult)
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
            },
            {
              "url": "/survey_results/2.json",
              "submitted_response_count": 271,
              "response_rate": 1,
              "participant_count": 271,
              "name": "Acme Engagement Survey"
            }
          ]
        }
        """

    surveyResultList : SurveyResultList
    surveyResultList =
        SurveyResultList
            [ SurveyResult
                "Simple Survey"
                6
                0.8333333333333334
                5
                Nothing
                "/survey_results/1.json"
            , SurveyResult
                "Acme Engagement Survey"
                271
                1
                271
                Nothing
                "/survey_results/2.json"
            ]

    Json.Decode.decodeString decoder json
    --> Ok surveyResultList

-}
decoder : Decode.Decoder SurveyResultList
decoder =
    let
        surveyResult =
            SurveyResult.Decoder.decoder
    in
        Decode.succeed
            SurveyResultList
            |: field "survey_results" (list surveyResult)
