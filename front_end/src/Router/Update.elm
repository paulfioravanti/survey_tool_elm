module Router.Update exposing (update)

{-| Updates the content of a route.
-}

import Navigation
import Router.Msg exposing (Msg(ChangeLocation, NoOp, OnLocationChange))
import Router.Route exposing (Route)
import Router.Utils
import Task


update : Msg -> (() -> msg) -> ( Route, Cmd msg )
update msg cmdMsg =
    case msg of
        ChangeLocation route ->
            ( route
            , route
                |> Router.Utils.toPath
                |> Navigation.newUrl
            )

        NoOp route ->
            ( route, Cmd.none )

        OnLocationChange location ->
            ( Router.Utils.toRoute location
            , Task.succeed ()
                |> Task.perform cmdMsg
            )
