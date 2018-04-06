module SurveyResult.Controller exposing (render)

import Html exposing (Html, text)
import Http
import Message.Loading as Loading
import Message.Error as Error
import Message.NotFound as NotFound
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
import SurveyResult.Model exposing (SurveyResult)
import SurveyResultDetail.View


render : msg -> String -> WebData SurveyResult -> Html msg
render msg path surveyResult =
    case surveyResult of
        NotRequested ->
            text ""

        Requesting ->
            Loading.view

        Failure error ->
            case error of
                Http.BadStatus response ->
                    case response.status.code of
                        404 ->
                            NotFound.view msg path

                        _ ->
                            error
                                |> errorToMessage
                                |> Error.view

                _ ->
                    error
                        |> errorToMessage
                        |> Error.view

        Success surveyResult ->
            SurveyResultDetail.View.view msg surveyResult


errorToMessage : Http.Error -> ( String, String )
errorToMessage error =
    case error of
        Http.NetworkError ->
            ( "network-error-message", "Is the server running?" )

        Http.BadStatus response ->
            ( "bad-status-message", toString response.status )

        Http.BadPayload message _ ->
            ( "bad-payload-message", "Decoding Failed: " ++ message )

        _ ->
            ( "other-error-message", toString error )
