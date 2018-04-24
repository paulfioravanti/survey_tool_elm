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
import SurveyResultDetail.Config exposing (Config)
import SurveyResultDetail.Context exposing (Context)
import SurveyResultDetail.View


render : Config msg -> Context -> WebData SurveyResult -> Html msg
render ({ backToHomeMsg, path } as config) context surveyResult =
    case surveyResult of
        NotRequested ->
            text ""

        Requesting ->
            Loading.view context.locale.translations

        Failure error ->
            case error of
                Http.BadStatus response ->
                    case response.status.code of
                        404 ->
                            let
                                config =
                                    { backToHomeMsg = backToHomeMsg
                                    , path = path
                                    }
                            in
                                NotFound.view config context.locale.translations

                        _ ->
                            Error.view error context.locale.translations

                _ ->
                    Error.view error context.locale.translations

        Success surveyResult ->
            surveyResult
                |> SurveyResultDetail.View.view config context
