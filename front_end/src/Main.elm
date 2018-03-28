module Main exposing (main)

import Config exposing (Config)
import Messages exposing (Msg(SurveyResultListMsg, UrlChange))
import Model exposing (Model)
import Navigation
import RemoteData exposing (RemoteData(Requesting))
import Routing.Parser
import Routing.Routes exposing (Route(ListSurveyResultsRoute, NotFoundRoute))
import SurveyResultList.Commands
import Update
import View


main : Program Config Model Msg
main =
    Navigation.programWithFlags
        UrlChange
        { init = init
        , view = View.view
        , update = Update.update
        , subscriptions = \_ -> Sub.none
        }


init : Config -> Navigation.Location -> ( Model, Cmd Msg )
init config location =
    let
        route =
            Routing.Parser.toRoute location

        model =
            Model.initialModel route config
    in
        case route of
            ListSurveyResultsRoute ->
                ( { model | surveyResultList = Requesting }
                , model.config.apiUrl
                    |> SurveyResultList.Commands.fetchSurveyResultList
                    |> Cmd.map SurveyResultListMsg
                )

            _ ->
                ( model, Cmd.none )
