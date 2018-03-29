module SurveyResultList.Decoder exposing (decoder)

import Json.Decode as Decode exposing (field, list)
import Json.Decode.Extra exposing ((|:))
import SurveyResult.Decoder
import SurveyResultList.Model exposing (SurveyResultList)


decoder : Decode.Decoder SurveyResultList
decoder =
    let
        surveyResult =
            SurveyResult.Decoder.decoder
    in
        Decode.succeed
            SurveyResultList
            |: (field "survey_results" (list surveyResult))
