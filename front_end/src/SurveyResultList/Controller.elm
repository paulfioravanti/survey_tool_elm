module SurveyResultList.Controller exposing (render)

import Html.Styled exposing (Html, text)
import Message.Loading as Loading
import Message.Error as Error
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


render : (String -> msg) -> WebData SurveyResultList -> Html msg
render msg surveyResultList =
    case surveyResultList of
        NotRequested ->
            text ""

        Requesting ->
            Loading.view

        Failure error ->
            Error.view error

        Success surveyResultList ->
            SurveyResultList.View.view msg surveyResultList
