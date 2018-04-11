module SurveyResult.Controller exposing (render)

import Html.Styled exposing (Html, text)
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
                            Error.view error

                _ ->
                    Error.view error

        Success surveyResult ->
            SurveyResultDetail.View.view msg path surveyResult
