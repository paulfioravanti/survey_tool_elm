module Main exposing (main, init, subscriptions)

{-| NOTE: The init function does not really need to be exposed for the app
to function, but this was the only way I could think of test it. I was
unable to figure out a way to test init through main.
-}

import Config exposing (Config)
import Flags exposing (Flags)
import Html.Styled as Html exposing (Html)
import Locale
import Model exposing (Model)
import Msg exposing (Msg(LocaleMsg, RoutingMsg, UpdatePage))
import Navigation exposing (Location)
import Router
import Task
import Update
import VirtualDom exposing (Node)


main : Program Flags Model Msg
main =
    Navigation.programWithFlags
        UpdatePage
        { init = init
        , view = view
        , update = Update.update
        , subscriptions = subscriptions
        }


init : Flags -> Location -> ( Model, Cmd Msg )
init flags location =
    let
        config =
            Config.init flags

        locale =
            Locale.init flags.language

        model =
            location
                |> Router.toRoute
                |> Model.initialModel config locale
    in
        ( model
        , Cmd.batch
            [ model.locale.language
                |> Locale.fetchTranslations
                |> Cmd.map LocaleMsg
            , Task.succeed location
                |> Task.perform UpdatePage
            ]
        )


view : Model -> Node Msg
view { locale, route, surveyResultList, surveyResultDetail } =
    let
        config =
            { changeLanguageMsg = (LocaleMsg << Locale.changeLanguageMsg)
            , updatePageMsg = UpdatePage
            }

        context =
            { locale = locale
            , route = route
            , surveyResultList = surveyResultList
            , surveyResultDetail = surveyResultDetail
            }
    in
        Router.route config context
            |> Html.map RoutingMsg
            |> Html.toUnstyled


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none
