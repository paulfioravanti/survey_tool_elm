module SurveyResult.Update exposing (update)

import RemoteData exposing (RemoteData(Failure, Success), WebData)
import SurveyResult.Msg exposing (Msg(FetchSurveyResult))
import SurveyResult.Model exposing (SurveyResult)


update : Msg -> ( WebData SurveyResult, Cmd Msg )
update msg =
    case msg of
        FetchSurveyResult (Ok response) ->
            ( Success response, Cmd.none )

        FetchSurveyResult (Err error) ->
            ( Failure error, Cmd.none )
