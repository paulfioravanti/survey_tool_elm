module Update exposing (update)

import Msg exposing (Msg(SurveyResultListMsg, RoutingMsg, UpdatePage))
import Model exposing (Model)
import RemoteData exposing (RemoteData(NotRequested, Requesting))
import Routing.Route
    exposing
        ( Route
            ( ListSurveyResultsRoute
            , SurveyResultDetailRoute
            )
        )
import Routing.Update
import SurveyResultList.Cmd
import SurveyResultList.Update


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

        RoutingMsg msg ->
            let
                ( route, cmd ) =
                    Routing.Update.update msg UpdatePage
            in
                ( { model | route = route }
                , cmd
                )

        UpdatePage _ ->
            case model.route of
                ListSurveyResultsRoute ->
                    case model.surveyResultList of
                        NotRequested ->
                            ( { model | surveyResultList = Requesting }
                            , model.config.apiUrl
                                |> SurveyResultList.Cmd.fetchSurveyResultList
                                |> Cmd.map SurveyResultListMsg
                            )

                        _ ->
                            ( model, Cmd.none )

                SurveyResultDetailRoute id ->
                    case model.surveyResultDetail of
                        _ ->
                            ( model, Cmd.none )

                _ ->
                    ( model, Cmd.none )
