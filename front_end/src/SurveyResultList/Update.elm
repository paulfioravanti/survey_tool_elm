module SurveyResultList.Update exposing (update)

{-| Updates the content of a survey result list.
-}

import RemoteData exposing (RemoteData(Failure, Success), WebData)
import SurveyResultList.Model exposing (SurveyResultList)
import SurveyResultList.Msg exposing (Msg(FetchSurveyResultList))
import Translations exposing (Lang)
import Window


update : Msg -> Lang -> ( WebData SurveyResultList, Cmd Msg )
update msg language =
    case msg of
        FetchSurveyResultList (Ok surveyResultList) ->
            ( Success surveyResultList
            , Window.updateTitle (Translations.surveyResults language)
            )

        FetchSurveyResultList (Err error) ->
            ( Failure error, Window.updateErrorTitle error language )
