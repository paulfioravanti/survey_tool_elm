module Router exposing (Msg, Route, onLocationChangeMsg, route, toRoute, update)

import Html.Styled as Html exposing (Html)
import I18Next exposing (Translations)
import Navigation
import Route as Route
import Router.Model exposing (Config)
import Router.Msg as Msg
import Router.Routing as Routing
import Router.Update as Update
import Router.Utils as Utils


type alias Msg =
    Msg.Msg


type alias Route =
    Route.Route


onLocationChangeMsg : Navigation.Location -> Msg
onLocationChangeMsg =
    Msg.OnLocationChange


route : Config -> Html Msg
route { locale, route, surveyResultList, surveyResultDetail } =
    Routing.route locale route surveyResultList surveyResultDetail


toRoute : Navigation.Location -> Route
toRoute location =
    Utils.toRoute location


update : Msg -> (() -> msg) -> Translations -> ( Route, Cmd msg )
update msg cmdMsg translations =
    Update.update msg cmdMsg translations
