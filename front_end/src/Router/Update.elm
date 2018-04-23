module Router.Update exposing (update)

{-| Updates the content of a route.
-}

import I18Next exposing (Translations)
import Navigation
import Route exposing (Route)
import Router.Model exposing (Config)
import Router.Msg
    exposing
        ( Msg
            ( Blur
            , ChangeLanguage
            , ChangeLocation
            , LocationChanged
            )
        )
import Router.Utils as Utils
import Task
import Window


update : Msg -> Config msg -> Translations -> ( Route, Cmd msg )
update msg config translations =
    case msg of
        Blur route ->
            ( route, Cmd.none )

        ChangeLanguage route language ->
            ( route
            , Cmd.batch
                [ Task.perform config.changeLanguageMsg (Task.succeed language)
                , Window.updateRouteTitle route translations
                ]
            )

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
            , Task.perform config.updatePageMsg (Task.succeed ())
            )
