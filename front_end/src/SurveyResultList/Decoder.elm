module SurveyResultList.Decoder exposing (decoder)

import SurveyResult.Decoder
import SurveyResultList.Model exposing (SurveyResultList)
import Json.Decode as Decode exposing (field, list)
import Json.Decode.Extra exposing ((|:))


decoder : Decode.Decoder SurveyResultList
decoder =
    let
        surveyResult =
            SurveyResult.Decoder.decoder
    in
        Decode.succeed
            SurveyResultList
            |: (field "survey_results" (list surveyResult))
