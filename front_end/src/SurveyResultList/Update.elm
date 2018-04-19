module SurveyResultList.Update exposing (update)

{-| Updates the content of a survey result list.
-}

import RemoteData exposing (RemoteData(Failure, Success), WebData)
import SurveyResultList.Msg exposing (Msg(FetchSurveyResultList))
import SurveyResultList.Model exposing (SurveyResultList)
import Window


update : Msg -> ( WebData SurveyResultList, Cmd Msg )
update msg =
    case msg of
        FetchSurveyResultList (Ok surveyResultList) ->
            ( Success surveyResultList, Window.updateTitle "Survey Results" )

        FetchSurveyResultList (Err error) ->
            ( Failure error, Window.updateErrorTitle error )
