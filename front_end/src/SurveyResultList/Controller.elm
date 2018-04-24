module SurveyResultList.Controller exposing (render)

{-| Determines what view should be rendered for a survey result list depending
on the status of the data fetched from the remote API point.
-}

import Html.Styled exposing (Html, text)
import I18Next exposing (Translations)
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
import SurveyResultList.Context exposing (Context)
import SurveyResultList.Model exposing (SurveyResultList)
import SurveyResultList.View


render : Config msg -> Context -> WebData SurveyResultList -> Html msg
render config context surveyResultList =
    case surveyResultList of
        NotRequested ->
            text ""

        Requesting ->
            Loading.view context.locale.translations

        Failure error ->
            Error.view error context.locale.translations

        Success surveyResultList ->
            SurveyResultList.View.view config context surveyResultList
