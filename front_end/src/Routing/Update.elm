module Routing.Update exposing (update)

import Navigation
import Routing.Msg exposing (Msg(NavigateTo, UrlChange))
import Routing.Router as Router
import Routing.Route exposing (Route)
import Task


update : Msg -> (() -> msg) -> ( Route, Cmd msg )
update msg cmdMsg =
    case msg of
        UrlChange location ->
            ( Router.toRoute location
            , Task.succeed ()
                |> Task.perform cmdMsg
            )

        NavigateTo route ->
            ( route
            , Navigation.newUrl (Router.toPath route)
            )
