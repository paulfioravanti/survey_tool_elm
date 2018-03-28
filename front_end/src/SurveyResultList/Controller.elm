module SurveyResultList.Controller exposing (render)

import Html exposing (Html, text)
import Http
import Messages.Loading as Loading
import Messages.Error as Error
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
import SurveyResultList.Model exposing (SurveyResultList)
import SurveyResultList.View


render : WebData SurveyResultList -> Html msg
render surveyResultList =
    case surveyResultList of
        NotRequested ->
            text ""

        Requesting ->
            Loading.view

        Failure error ->
            error
                |> errorToMessage
                |> Error.view

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
