module SurveyResultList.Controller exposing (render)

{-| Determines what view should be rendered for a survey result list depending
on the status of the data fetched from the remote API point.
-}

import Html.Styled exposing (Html, text)
import Locale exposing (Locale)
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
import SurveyResultList.Config exposing (Config)
import SurveyResultList.Model exposing (SurveyResultList)
import SurveyResultList.View


render : Config msg -> Locale -> WebData SurveyResultList -> Html msg
render config locale surveyResultList =
    case surveyResultList of
        NotRequested ->
            text ""

        Requesting ->
            Loading.view locale.translations

        Failure error ->
            Error.view error locale.translations

        Success surveyResultList ->
            SurveyResultList.View.view config locale surveyResultList
