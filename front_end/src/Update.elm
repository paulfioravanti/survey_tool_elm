module Update exposing (update)

import Messages exposing (Msg(SurveyResultListMsg))
import Model exposing (Model)
import SurveyResultList.Update


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        SurveyResultListMsg msg ->
            let
                ( surveyResultList, cmd ) =
                    SurveyResultList.Update.update msg
            in
                ( { model | surveyResultList = surveyResultList }
                , Cmd.none
                )
