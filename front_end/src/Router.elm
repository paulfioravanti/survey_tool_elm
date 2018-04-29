module Router
    exposing
        ( Msg
        , Route
        , changeLocationMsg
        , route
        , toRoute
        , update
        )

import Html.Styled as Html exposing (Html)
import I18Next exposing (Translations)
import Navigation exposing (Location)
import Route as Route exposing (Route)
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


changeLocationMsg : Route -> Msg
changeLocationMsg =
    Msg.ChangeLocation


route : Config msg -> Context -> Html msg
route config context =
    Routing.route config context


toRoute : Location -> Route
toRoute location =
    Utils.toRoute location


update : Msg -> Config msg -> Translations -> ( Route, Cmd msg )
update msg config translations =
    Update.update msg config translations
