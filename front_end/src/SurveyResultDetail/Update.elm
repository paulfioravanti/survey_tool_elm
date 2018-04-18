module SurveyResultDetail.Update exposing (update)

{-| Updates the content of a detailed survey result.
-}

import RemoteData exposing (RemoteData(Failure, Success), WebData)
import SurveyResult exposing (SurveyResult)
import SurveyResultDetail.Msg exposing (Msg(FetchSurveyResultDetail))


update : Msg -> ( WebData SurveyResult, Cmd Msg )
update msg =
    case msg of
        FetchSurveyResultDetail (Ok response) ->
            ( Success response, Cmd.none )

        FetchSurveyResultDetail (Err error) ->
            ( Failure error, Cmd.none )
