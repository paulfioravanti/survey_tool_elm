module SurveyResult.Data exposing (init, load, title, view)

import Data
import Html.Styled as Html exposing (Html)
import Http
import Json.Decode exposing (Decoder)
import Language exposing (Language)
import Page.Error as Error
import Page.Loading as Loading
import RemoteData exposing (WebData)
import SurveyResult.Detail.Decoder as Decoder
import SurveyResult.Detail.View as View
import SurveyResult.Model exposing (SurveyResult)
import SurveyResult.Msg as Msg exposing (Msg)
import SurveyResult.Parser as Parser
import Translations


init : WebData SurveyResult
init =
    RemoteData.NotAsked


load :
    String
    -> String
    -> WebData SurveyResult
    -> ( WebData SurveyResult, Cmd Msg )
load apiUrl id webData =
    let
        url : String
        url =
            apiUrl ++ id

        decoder : Decoder SurveyResult
        decoder =
            Decoder.decoder

        callbackMsg : WebData SurveyResult -> Msg
        callbackMsg =
            Msg.fetched
    in
    case webData of
        -- Fetch data if it has not been asked for yet.
        RemoteData.NotAsked ->
            ( RemoteData.Loading, Data.fetch url decoder callbackMsg )

        -- Do nothing if the data is currently still loading.
        RemoteData.Loading ->
            ( webData, Cmd.none )

        -- Use the current cached survey result detail in the model if we're
        -- requesting it again. Otherwise, fetch the new data.
        RemoteData.Success surveyResult ->
            if Parser.id surveyResult == id then
                ( webData, Cmd.none )

            else
                ( RemoteData.Loading, Data.fetch url decoder callbackMsg )

        -- Attempt to re-fetch remote data if the last fetch resulted
        -- in failure.
        RemoteData.Failure _ ->
            ( RemoteData.Loading, Data.fetch url decoder callbackMsg )


title : Language -> WebData SurveyResult -> String
title language webData =
    case webData of
        RemoteData.NotAsked ->
            ""

        RemoteData.Loading ->
            Translations.loading language

        RemoteData.Success surveyResult ->
            surveyResult.name

        RemoteData.Failure (Http.BadStatus 404) ->
            Translations.notFound language

        RemoteData.Failure _ ->
            Translations.errorRetrievingData language


view : Language -> WebData SurveyResult -> Html msg
view language webData =
    case webData of
        RemoteData.NotAsked ->
            Html.text ""

        RemoteData.Loading ->
            Loading.view language

        RemoteData.Success surveyResult ->
            View.view language surveyResult

        RemoteData.Failure error ->
            Error.view language error
