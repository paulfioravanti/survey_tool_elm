module SurveyResult
    exposing
        ( SurveyResult
        , decoder
        , view
        )

import Html.Styled exposing (Html)
import Json.Decode as Decode
import RemoteData exposing (WebData)
import SurveyResult.Decoder as Decoder
import SurveyResult.Model as Model
import SurveyResult.View as View


type alias SurveyResult =
    Model.SurveyResult


decoder : Decode.Decoder SurveyResult
decoder =
    Decoder.decoder


view : (String -> msg) -> SurveyResult -> Html msg
view msg surveyResult =
    View.view msg surveyResult
