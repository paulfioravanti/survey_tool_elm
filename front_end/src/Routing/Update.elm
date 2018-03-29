module Routing.Update exposing (update)

import Navigation
import Routing.Msg exposing (Msg(ChangeLocation, OnLocationChange))
import Routing.Router as Router
import Routing.Route exposing (Route)
import Task


update : Msg -> (() -> msg) -> ( Route, Cmd msg )
update msg cmdMsg =
    case msg of
        ChangeLocation route ->
            ( route
            , Navigation.newUrl (Router.toPath route)
            )

        OnLocationChange location ->
            ( Router.toRoute location
            , Task.succeed ()
                |> Task.perform cmdMsg
            )
