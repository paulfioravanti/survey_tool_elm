module SurveyResultDetail.Update exposing (update)

{-| Updates the content of a detailed survey result.
-}

import I18Next exposing (Translations)
import RemoteData exposing (RemoteData(Failure, Success), WebData)
import SurveyResult exposing (SurveyResult)
import SurveyResultDetail.Msg exposing (Msg(FetchSurveyResultDetail))
import Window


update : Msg -> Translations -> ( WebData SurveyResult, Cmd Msg )
update msg translations =
    case msg of
        FetchSurveyResultDetail (Ok surveyResult) ->
            ( Success surveyResult, Window.updateTitle surveyResult.name )

        FetchSurveyResultDetail (Err error) ->
            ( Failure error, Window.updateErrorTitle error translations )
