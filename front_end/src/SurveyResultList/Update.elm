module SurveyResultList.Update exposing (update)

import SurveyResultList.Messages exposing (Msg(FetchSurveyResultList))
import SurveyResultList.Model exposing (SurveyResultList)


update : Msg -> ( SurveyResultList, Cmd Msg )
update msg =
    case msg of
        FetchSurveyResultList (Ok response) ->
            ( response, Cmd.none )

        FetchSurveyResultList (Err error) ->
            ( errorList, Cmd.none )


errorList : SurveyResultList
errorList =
    SurveyResultList.Model.initialSurveyResultList
