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
import SurveyResultList.View


render : WebData SurveyResultList -> Html msg
render surveyResultList =
    case surveyResultList of
        NotRequested ->
            text ""

        Requesting ->
            LoadingMessage.view

        Failure error ->
            text "Unable to get survey results"

        Success surveyResultList ->
            SurveyResultList.View.view surveyResultList
