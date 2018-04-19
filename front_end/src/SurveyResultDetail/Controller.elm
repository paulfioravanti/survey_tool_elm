module SurveyResultDetail.Controller exposing (render)

{-| Determines what view should be rendered for a survey result depending
on the status of the data fetched from the remote API point.
-}

import Html.Styled exposing (Html, text)
import Http
import I18Next exposing (Translations)
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
import SurveyResult exposing (SurveyResult)
import SurveyResultDetail.View


render :
    msg
    -> msg
    -> String
    -> Translations
    -> WebData SurveyResult
    -> Html msg
render msg noOpMsg path translations surveyResult =
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
                            NotFound.view msg path translations

                        _ ->
                            Error.view error

                _ ->
                    Error.view error

        Success surveyResult ->
            surveyResult
                |> SurveyResultDetail.View.view msg noOpMsg path translations
