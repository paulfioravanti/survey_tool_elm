module SurveyResultDetail.Controller exposing (render)

{-| Determines what view should be rendered for a survey result depending
on the status of the data fetched from the remote API point.
-}

import Html.Styled exposing (Html, text)
import Http
import Locale exposing (Locale)
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
import SurveyResultDetail.View


render : Config msg -> Locale -> WebData SurveyResult -> Html msg
render ({ backToHomeMsg, backToHomePath } as config) locale surveyResultData =
    case surveyResultData of
        NotRequested ->
            text ""

        Requesting ->
            Loading.view locale.language

        Failure error ->
            case error of
                Http.BadStatus response ->
                    case response.status.code of
                        404 ->
                            let
                                notFoundConfig =
                                    { backToHomeMsg = backToHomeMsg
                                    , backToHomePath = backToHomePath
                                    }
                            in
                                NotFound.view notFoundConfig locale.language

                        _ ->
                            Error.view error locale.language

                _ ->
                    Error.view error locale.language

        Success surveyResult ->
            SurveyResultDetail.View.view config locale surveyResult
