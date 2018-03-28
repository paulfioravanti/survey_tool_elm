module Update exposing (update)

import Msg exposing (Msg(SurveyResultListMsg, UrlChange, UpdatePage))
import Model exposing (Model)
import RemoteData exposing (RemoteData(NotRequested, Requesting))
import Router
import Routes exposing (Route(ListSurveyResultsRoute))
import SurveyResultList.Cmd
import SurveyResultList.Update
import Task


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        SurveyResultListMsg msg ->
            let
                ( surveyResultList, cmd ) =
                    SurveyResultList.Update.update msg
            in
                ( { model | surveyResultList = surveyResultList }
                , Cmd.map SurveyResultListMsg cmd
                )

        UrlChange location ->
            let
                route =
                    Router.toRoute location
            in
                ( { model | route = route }
                , Task.succeed ()
                    |> Task.perform UpdatePage
                )

        UpdatePage _ ->
            case model.route of
                ListSurveyResultsRoute ->
                    case model.surveyResultList of
                        NotRequested ->
                            ( { model | surveyResultList = Requesting }
                            , fetchSurveyResultList model.config.apiUrl
                            )

                        _ ->
                            ( model, Cmd.none )

                _ ->
                    ( model, Cmd.none )


fetchSurveyResultList : String -> Cmd Msg
fetchSurveyResultList apiUrl =
    apiUrl
        |> SurveyResultList.Cmd.fetchSurveyResultList
        |> Cmd.map SurveyResultListMsg
