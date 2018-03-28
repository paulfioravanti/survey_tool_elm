module SurveyResultList.Controller exposing (render)

import Html exposing (Html, text)
import Http
import SurveyResultList.Model exposing (SurveyResultList)
import RemoteData
    exposing
        ( RemoteData
            ( NotRequested
            , Requesting
            , Failure
            , Success
            )
        , WebData
        )
import Shared.LoadingMessage as LoadingMessage
import Shared.ErrorMessage as ErrorMessage
import SurveyResultList.View


render : WebData SurveyResultList -> Html msg
render surveyResultList =
    case surveyResultList of
        NotRequested ->
            text ""

        Requesting ->
            LoadingMessage.view

        Failure error ->
            error
                |> errorToMessage
                |> ErrorMessage.view

        Success surveyResultList ->
            SurveyResultList.View.view surveyResultList


errorToMessage : Http.Error -> String
errorToMessage error =
    case error of
        Http.NetworkError ->
            "Is the server running?"

        Http.BadStatus response ->
            toString response.status

        Http.BadPayload message _ ->
            "Decoding Failed: " ++ message

        _ ->
            toString error
