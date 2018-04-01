module SurveyResultList.Encoder exposing (encoder)

import Json.Encode as Encode
import SurveyResult.Encoder
import SurveyResultList.Model exposing (SurveyResultList)


encoder : SurveyResultList -> Encode.Value
encoder surveyResultList =
    let
        surveyResults =
            surveyResultList.surveyResults
                |> List.map SurveyResult.Encoder.encoder
    in
        Encode.object
            [ ( "survey_results", Encode.list surveyResults ) ]
