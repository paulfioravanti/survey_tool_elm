module SurveyResultDetail exposing (decoder)

import Json.Decode as Decode
import SurveyResult exposing (SurveyResult)
import SurveyResultDetail.Decoder as Decoder


decoder : Decode.Decoder SurveyResult
decoder =
    Decoder.decoder
