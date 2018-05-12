module SurveyResultDetail.Update exposing (update)

{-| Updates the content of a detailed survey result.
-}

import RemoteData exposing (RemoteData(Failure, Success), WebData)
import SurveyResult exposing (SurveyResult)
import SurveyResultDetail.Msg exposing (Msg(FetchSurveyResultDetail))
import Translations exposing (Lang)
import Window


update : Msg -> Lang -> ( WebData SurveyResult, Cmd Msg )
update msg language =
    case msg of
        FetchSurveyResultDetail (Ok surveyResult) ->
            ( Success surveyResult, Window.updateTitle surveyResult.name )

        FetchSurveyResultDetail (Err error) ->
            ( Failure error, Window.updateErrorTitle error language )
