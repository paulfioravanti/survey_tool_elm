module SurveyResult
    exposing
        ( SurveyResult
        , decoder
        , id
        , view
        )

import Html.Styled exposing (Html)
import Json.Decode as Decode exposing (Decoder)
import SurveyResult.Decoder as Decoder
import SurveyResult.Model as Model
import SurveyResult.Utils as Utils
import SurveyResult.View as View
import Translations exposing (Lang)


type alias SurveyResult =
    Model.SurveyResult


decoder : Decoder SurveyResult
decoder =
    Decoder.decoder


id : SurveyResult -> String
id surveyResult =
    Utils.extractId surveyResult.url


view : (String -> msg) -> Lang -> SurveyResult -> Html msg
view surveyResultDetailMsg language surveyResult =
    View.view surveyResultDetailMsg language surveyResult
