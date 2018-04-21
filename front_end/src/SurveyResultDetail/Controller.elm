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
import SurveyResultDetail.Model exposing (Config)
import SurveyResultDetail.View


render : Config msg -> Translations -> WebData SurveyResult -> Html msg
render ({ backToHomeMsg, path } as config) translations surveyResult =
    case surveyResult of
        NotRequested ->
            text ""

        Requesting ->
            Loading.view translations

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
                                NotFound.view config translations

                        _ ->
                            Error.view error translations

                _ ->
                    Error.view error translations

        Success surveyResult ->
            surveyResult
                |> SurveyResultDetail.View.view config translations
