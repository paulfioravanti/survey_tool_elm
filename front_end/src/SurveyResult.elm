module SurveyResult
    exposing
        ( SurveyResult
        , decoder
        , view
        )

import Html.Styled exposing (Html)
import I18Next exposing (Translations)
import Json.Decode as Decode
import SurveyResult.Decoder as Decoder
import SurveyResult.Model as Model exposing (Config)
import SurveyResult.View as View


type alias SurveyResult =
    Model.SurveyResult


decoder : Decode.Decoder SurveyResult
decoder =
    Decoder.decoder


view : Config msg -> Translations -> SurveyResult -> Html msg
view config translations surveyResult =
    View.view config translations surveyResult
