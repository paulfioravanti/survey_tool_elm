module SurveyResultList.Encoder exposing (encode)

import Json.Encode as Encode
import SurveyResult.Encoder as SurveyResult
import SurveyResultList exposing (SurveyResultList)


encode : SurveyResultList -> Encode.Value
encode surveyResultList =
    Encode.object
        [ ( "survey_results"
          , Encode.list SurveyResult.encode surveyResultList.surveyResults
          )
        ]
