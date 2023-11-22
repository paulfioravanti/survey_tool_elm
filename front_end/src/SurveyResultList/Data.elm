module SurveyResultList.Data exposing (init, load, title, view)

import Data
import Html.Styled as Html exposing (Html)
import Http
import Language exposing (Language)
import Page.Error as Error
import Page.Loading as Loading
import RemoteData exposing (WebData)
import SurveyResultList.Decoder as Decoder
import SurveyResultList.Model exposing (SurveyResultList)
import SurveyResultList.Msg as Msg exposing (Msg)
import SurveyResultList.View as View
import Translations


init : WebData SurveyResultList
init =
    RemoteData.NotAsked


load :
    String
    -> WebData SurveyResultList
    -> ( WebData SurveyResultList, Cmd Msg )
load apiUrl webData =
    let
        decoder =
            Decoder.decoder

        callbackMsg =
            Msg.fetched
    in
    case webData of
        -- Fetch data if it has not been asked for yet.
        RemoteData.NotAsked ->
            ( RemoteData.Loading, Data.fetch apiUrl decoder callbackMsg )

        -- Do nothing if the data is currently still loading.
        RemoteData.Loading ->
            ( webData, Cmd.none )

        -- Use the current cached survey result list in the model if it
        -- has already been loaded.
        RemoteData.Success _ ->
            ( webData, Cmd.none )

        -- Attempt to re-fetch remote data if the last fetch resulted
        -- in failure.
        RemoteData.Failure _ ->
            ( RemoteData.Loading, Data.fetch apiUrl decoder callbackMsg )


title : Language -> WebData SurveyResultList -> String
title language surveyResultList =
    case surveyResultList of
        RemoteData.NotAsked ->
            ""

        RemoteData.Loading ->
            Translations.loading language

        RemoteData.Success _ ->
            Translations.surveyResults language

        RemoteData.Failure (Http.BadStatus 404) ->
            Translations.notFound language

        RemoteData.Failure _ ->
            Translations.errorRetrievingData language


view : Language -> WebData SurveyResultList -> Html msg
view language webData =
    case webData of
        RemoteData.NotAsked ->
            Html.text ""

        RemoteData.Loading ->
            Loading.view language

        RemoteData.Success data ->
            View.view language data

        RemoteData.Failure error ->
            Error.view language error
