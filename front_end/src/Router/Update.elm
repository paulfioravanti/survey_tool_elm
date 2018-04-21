module Router.Update exposing (update)

{-| Updates the content of a route.
-}

import I18Next exposing (Translations)
import Navigation
import Router.Msg exposing (Msg(Blur, ChangeLocation, OnLocationChange))
import Route exposing (Route)
import Router.Utils as Utils
import Task
import Window


update : Msg -> (() -> msg) -> Translations -> ( Route, Cmd msg )
update msg cmdMsg translations =
    case msg of
        Blur route ->
            ( route, Cmd.none )

        ChangeLocation route ->
            ( route
            , Cmd.batch
                [ route
                    |> Utils.toPath
                    |> Navigation.newUrl
                , Window.updateRouteTitle route translations
                ]
            )

        OnLocationChange location ->
            ( Utils.toRoute location
            , Task.succeed ()
                |> Task.perform cmdMsg
            )
