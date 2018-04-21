module SurveyResultList.Encoder exposing (encoder)

import Json.Encode as Encode
import SurveyResult.Encoder as Encoder
import SurveyResultList exposing (SurveyResultList)


encoder : SurveyResultList -> Encode.Value
encoder surveyResultList =
    let
        surveyResults =
            surveyResultList.surveyResults
                |> List.map Encoder.encoder
    in
        Encode.object
            [ ( "survey_results", Encode.list surveyResults ) ]
