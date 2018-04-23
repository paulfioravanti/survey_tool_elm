module Router exposing (Msg, Route, route, toRoute, update)

import Html.Styled as Html exposing (Html)
import I18Next exposing (Translations)
import Navigation exposing (Location)
import Route as Route
import Router.Config exposing (Config)
import Router.Context exposing (Context)
import Router.Msg as Msg
import Router.Routing as Routing
import Router.Update as Update
import Router.Utils as Utils


type alias Msg =
    Msg.Msg


type alias Route =
    Route.Route


route : Context -> Html Msg
route context =
    Routing.route context


toRoute : Location -> Route
toRoute location =
    Utils.toRoute location


update : Msg -> Config msg -> Translations -> ( Route, Cmd msg )
update msg config translations =
    Update.update msg config translations
