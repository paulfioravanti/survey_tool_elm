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
    location
        |> Routing.Parser.toRoute
        |> Model.initialModel config
        |> Update.updateUrl
