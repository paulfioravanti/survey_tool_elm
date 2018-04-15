module Routing.Update exposing (update)

{-| Updates the content of a route.
-}

import Navigation
import Routing.Msg exposing (Msg(ChangeLocation, NoOp, OnLocationChange))
import Routing.Route exposing (Route)
import Routing.Utils
import Task


update : Msg -> (() -> msg) -> ( Route, Cmd msg )
update msg cmdMsg =
    case msg of
        ChangeLocation route ->
            ( route
            , route
                |> Routing.Utils.toPath
                |> Navigation.newUrl
            )

        NoOp route ->
            ( route, Cmd.none )

        OnLocationChange location ->
            ( Routing.Utils.toRoute location
            , Task.succeed ()
                |> Task.perform cmdMsg
            )
