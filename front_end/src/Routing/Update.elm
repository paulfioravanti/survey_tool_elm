module Routing.Update exposing (update)

import Routing.Msg exposing (Msg(UrlChange))
import Routing.Router as Router
import Routing.Routes exposing (Route)


update : Msg -> ( Route, Cmd Msg )
update msg =
    case msg of
        UrlChange location ->
            ( Router.toRoute location, Cmd.none )
