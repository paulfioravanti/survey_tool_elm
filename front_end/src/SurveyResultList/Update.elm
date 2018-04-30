module SurveyResultList.Update exposing (update)

{-| Updates the content of a survey result list.
-}

import I18Next exposing (Translations)
import RemoteData exposing (RemoteData(Failure, Success), WebData)
import SurveyResultList.Model exposing (SurveyResultList)
import SurveyResultList.Msg exposing (Msg(FetchSurveyResultList))
import Window


update : Msg -> Translations -> ( WebData SurveyResultList, Cmd Msg )
update msg translations =
    case msg of
        FetchSurveyResultList (Ok surveyResultList) ->
            ( Success surveyResultList
            , Window.updateTitle (I18Next.t translations "surveyResults")
            )

        FetchSurveyResultList (Err error) ->
            ( Failure error, Window.updateErrorTitle error translations )
