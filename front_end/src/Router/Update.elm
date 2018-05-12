module Router.Update exposing (update)

{-| Updates the content of a route.
-}

import Navigation
import Route exposing (Route)
import Router.Config exposing (Config)
import Router.Msg exposing (Msg(ChangeLocation))
import Router.Utils as Utils
import Translations exposing (Lang)
import Window


update : Msg -> Config msg -> Lang -> ( Route, Cmd msg )
update msg config language =
    case msg of
        ChangeLocation route ->
            ( route
            , Cmd.batch
                [ route
                    |> Utils.toPath
                    |> Navigation.newUrl
                , Window.updateRouteTitle route language
                ]
            )
