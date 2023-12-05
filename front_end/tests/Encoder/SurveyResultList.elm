module Encoder.SurveyResultList exposing (encode)

import Encoder.SurveyResult as SurveyResult
import Json.Encode as Encode
import SurveyResultList exposing (SurveyResultList)


encode : SurveyResultList -> Encode.Value
encode surveyResultList =
    Encode.object
        [ ( "survey_results"
          , Encode.list SurveyResult.encode surveyResultList.surveyResults
          )
        ]
