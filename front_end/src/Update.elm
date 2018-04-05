module Update exposing (update)

import Msg exposing (Msg(SurveyResultListMsg, RoutingMsg, UpdatePage))
import Model exposing (Model)
import Page.Update
import Routing.Update
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
            Page.Update.update model
