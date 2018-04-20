module Main exposing (main, init, subscriptions)

{-| NOTE: The init function does not really need to be exposed for the app
to function, but this was the only way I could think of test it. I was
unable to figure out a way to test init through main.
-}

import Config exposing (Config)
import Flags exposing (Flags)
import Html.Styled as Html exposing (Html)
import I18Next
import Locale
import Model exposing (Model)
import Msg exposing (Msg(RoutingMsg, TranslationsLoaded, UpdatePage))
import Navigation
import Router
import Task
import Update
import VirtualDom


main : Program Flags Model Msg
main =
    Navigation.programWithFlags
        (Router.onLocationChangeMsg >> RoutingMsg)
        { init = init
        , view = view
        , update = Update.update
        , subscriptions = subscriptions
        }


init : Flags -> Navigation.Location -> ( Model, Cmd Msg )
init flags location =
    let
        config =
            Config.init flags

        model =
            location
                |> Router.toRoute
                |> Model.initialModel config
    in
        ( model
        , Cmd.batch
            [ Task.succeed ()
                |> Task.perform UpdatePage
            , I18Next.fetchTranslations
                TranslationsLoaded
                (Locale.translationsUrl config.language)
            ]
        )


view : Model -> VirtualDom.Node Msg
view =
    Router.route
        >> Html.map RoutingMsg
        >> Html.toUnstyled


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none
