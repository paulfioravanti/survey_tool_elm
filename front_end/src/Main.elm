module Main exposing (main)

import Html
import Messages exposing (Msg(SurveyResultListMsg))
import Model exposing (Model)
import RemoteData exposing (RemoteData(Requesting))
import SurveyResultList.Commands
import Update
import View


main : Program Never Model Msg
main =
    Html.program
        { init = init
        , view = View.view
        , update = Update.update
        , subscriptions = always Sub.none
        }


init : ( Model, Cmd Msg )
init =
    let
        model =
            Model.initialModel
    in
        ( { model | surveyResultList = Requesting }
        , SurveyResultList.Commands.fetchSurveyResultList
            |> Cmd.map SurveyResultListMsg
        )
