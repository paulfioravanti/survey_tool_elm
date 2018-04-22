module Router.Update exposing (update)

{-| Updates the content of a route.
-}

import I18Next exposing (Translations)
import Navigation
import Route exposing (Route)
import Router.Msg exposing (Msg(Blur, ChangeLocation, LocationChanged))
import Router.Utils as Utils
import Task
import Window


update : Msg -> (() -> msg) -> Translations -> ( Route, Cmd msg )
update msg updatePageMsg translations =
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

        LocationChanged location ->
            ( Utils.toRoute location
            , Task.perform updatePageMsg (Task.succeed ())
            )
