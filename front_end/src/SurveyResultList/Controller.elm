module SurveyResultList.Controller exposing (render)

import Html exposing (Html, text)
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
            ErrorMessage.view

        Success surveyResultList ->
            SurveyResultList.View.view surveyResultList
