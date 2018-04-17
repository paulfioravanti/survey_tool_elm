module Update exposing (update)

import Msg
    exposing
        ( Msg
            ( SurveyResultMsg
            , SurveyResultListMsg
            , RoutingMsg
            , UpdatePage
            )
        )
import Model exposing (Model)
import Page.Update
import Routing.Update
import SurveyResult.Update
import SurveyResultList


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        SurveyResultMsg msg ->
            let
                ( surveyResultDetail, cmd ) =
                    SurveyResult.Update.update msg
            in
                ( { model | surveyResultDetail = surveyResultDetail }
                , Cmd.map SurveyResultMsg cmd
                )

        SurveyResultListMsg msg ->
            let
                ( surveyResultList, cmd ) =
                    SurveyResultList.update msg
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
