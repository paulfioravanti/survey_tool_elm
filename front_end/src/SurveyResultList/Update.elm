module SurveyResultList.Update exposing (update)

{-| Updates the content of a survey result list.
-}

import RemoteData exposing (RemoteData(Failure, Success), WebData)
import SurveyResultList.Msg exposing (Msg(FetchSurveyResultList))
import SurveyResultList.Model exposing (SurveyResultList)


update : Msg -> ( WebData SurveyResultList, Cmd Msg )
update msg =
    case msg of
        FetchSurveyResultList (Ok response) ->
            ( Success response, Cmd.none )

        FetchSurveyResultList (Err error) ->
            ( Failure error, Cmd.none )
