module SurveyResultDetail
    exposing
        ( Msg
        , decoder
        , fetchSurveyResult
        , update
        , view
        )

import Html.Styled exposing (Html)
import I18Next exposing (Translations)
import Json.Decode as Decode exposing (Decoder)
import Locale exposing (Locale)
import RemoteData exposing (WebData)
import SurveyResult exposing (SurveyResult)
import SurveyResultDetail.Cmd as Cmd
import SurveyResultDetail.Config exposing (Config)
import SurveyResultDetail.Controller as Controller
import SurveyResultDetail.Decoder as Decoder
import SurveyResultDetail.Msg as Msg
import SurveyResultDetail.Update as Update


type alias Msg =
    Msg.Msg


decoder : Decoder SurveyResult
decoder =
    Decoder.decoder


fetchSurveyResult : String -> String -> Cmd Msg
fetchSurveyResult id apiUrl =
    Cmd.fetchSurveyResult id apiUrl


update : Msg -> Translations -> ( WebData SurveyResult, Cmd Msg )
update msg translations =
    Update.update msg translations


view : Config msg -> Locale -> WebData SurveyResult -> Html msg
view config locale surveyResult =
    Controller.render config locale surveyResult
