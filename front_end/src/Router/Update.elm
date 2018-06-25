module Router.Update exposing (update)

{-| Updates the content of a route.
-}

import Navigation
import Route exposing (Route)
import Router.Msg exposing (Msg(ChangeLocation))
import Router.Utils as Utils
import Translations exposing (Lang)
import Window


update : Msg -> Lang -> ( Route, Cmd msg )
update msg language =
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
