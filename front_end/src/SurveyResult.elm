module SurveyResult exposing
    ( Msg
    , SurveyResult
    , decoder
    , detailView
    , init
    , load
    , summaryView
    , title
    , update
    )

import Html.Styled exposing (Html)
import Json.Decode exposing (Decoder)
import Language exposing (Language)
import RemoteData exposing (WebData)
import SurveyResult.Cmd as Cmd
import SurveyResult.Data as Data
import SurveyResult.Decoder as Decoder
import SurveyResult.Model as Model
import SurveyResult.Msg as Msg
import SurveyResult.Summary.View as Summary
import SurveyResult.Update as Update


type alias SurveyResult =
    Model.SurveyResult


type alias Msg =
    Msg.Msg


decoder : Decoder SurveyResult
decoder =
    Decoder.decoder


detailView : Language -> WebData SurveyResult -> Html msg
detailView language webData =
    Data.view language webData


init : WebData SurveyResult
init =
    Data.init


load : String -> String -> WebData SurveyResult -> Cmd Msg
load apiUrl surveyResultid surveyResult =
    Cmd.load apiUrl surveyResultid surveyResult


summaryView : Language -> SurveyResult -> Html msg
summaryView language surveyResult =
    Summary.view language surveyResult


title : Language -> WebData SurveyResult -> String
title language webData =
    Data.title language webData


update : Language -> Msg -> ( WebData SurveyResult, String, Cmd Msg )
update language msg =
    Update.update language msg
