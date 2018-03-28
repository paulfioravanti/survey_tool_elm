module Routing.Update exposing (update)

import Routing.Msg exposing (Msg(UrlChange))
import Routing.Router as Router
import Routing.Routes exposing (Route)
import Task


update : Msg -> (() -> msg) -> ( Route, Cmd msg )
update msg cmdMsg =
    case msg of
        UrlChange location ->
            ( Router.toRoute location
            , Task.succeed ()
                |> Task.perform cmdMsg
            )
