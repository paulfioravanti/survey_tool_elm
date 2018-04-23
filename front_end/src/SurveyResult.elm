module SurveyResult
    exposing
        ( SurveyResult
        , decoder
        , view
        )

import Html.Styled exposing (Html)
import I18Next exposing (Translations)
import Json.Decode as Decode exposing (Decoder)
import SurveyResult.Config exposing (Config)
import SurveyResult.Decoder as Decoder
import SurveyResult.Model as Model
import SurveyResult.View as View


type alias SurveyResult =
    Model.SurveyResult


decoder : Decoder SurveyResult
decoder =
    Decoder.decoder


view : Config msg -> Translations -> SurveyResult -> Html msg
view config translations surveyResult =
    View.view config translations surveyResult
