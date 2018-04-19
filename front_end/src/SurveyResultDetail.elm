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
import Json.Decode as Decode
import RemoteData exposing (WebData)
import SurveyResult exposing (SurveyResult)
import SurveyResultDetail.Cmd as Cmd
import SurveyResultDetail.Controller as Controller
import SurveyResultDetail.Decoder as Decoder
import SurveyResultDetail.Msg as Msg
import SurveyResultDetail.Update as Update


type alias Msg =
    Msg.Msg


decoder : Decode.Decoder SurveyResult
decoder =
    Decoder.decoder


fetchSurveyResult : String -> String -> Cmd Msg
fetchSurveyResult id apiUrl =
    Cmd.fetchSurveyResult id apiUrl


update : Msg -> Translations -> ( WebData SurveyResult, Cmd Msg )
update msg translations =
    Update.update msg translations


view : msg -> msg -> String -> Translations -> WebData SurveyResult -> Html msg
view msg noOpMsg path translations surveyResult =
    Controller.render msg noOpMsg path translations surveyResult
