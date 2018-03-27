module Main exposing (main)

import Config exposing (Config)
import Html
import Messages exposing (Msg(SurveyResultListMsg))
import Model exposing (Model)
import RemoteData exposing (RemoteData(Requesting))
import SurveyResultList.Commands
import Update
import View


main : Program Config Model Msg
main =
    Html.programWithFlags
        { init = init
        , view = View.view
        , update = Update.update
        , subscriptions = \_ -> Sub.none
        }


init : Config -> ( Model, Cmd Msg )
init config =
    let
        model =
            Model.initialModel config
    in
        ( { model | surveyResultList = Requesting }
        , model.config.apiUrl
            |> SurveyResultList.Commands.fetchSurveyResultList
            |> Cmd.map SurveyResultListMsg
        )
