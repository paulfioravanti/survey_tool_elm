module SurveyResult
    exposing
        ( SurveyResult
        , decoder
        , id
        , view
        )

import Html.Styled exposing (Html)
import I18Next exposing (Translations)
import Json.Decode as Decode exposing (Decoder)
import SurveyResult.Decoder as Decoder
import SurveyResult.Model as Model
import SurveyResult.Utils as Utils
import SurveyResult.View as View


type alias SurveyResult =
    Model.SurveyResult


decoder : Decoder SurveyResult
decoder =
    Decoder.decoder


id : SurveyResult -> String
id surveyResult =
    Utils.extractId surveyResult.url


view : (String -> msg) -> Translations -> SurveyResult -> Html msg
view surveyResultDetailMsg translations surveyResult =
    View.view surveyResultDetailMsg translations surveyResult
