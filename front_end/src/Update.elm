module Update exposing (update, updateUrl)

import Messages exposing (Msg(SurveyResultListMsg, UrlChange))
import Model exposing (Model)
import RemoteData exposing (RemoteData(NotRequested, Requesting))
import Routing.Parser
import Routing.Routes exposing (Route(ListSurveyResultsRoute))
import SurveyResultList.Commands
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

        UrlChange location ->
            let
                route =
                    Routing.Parser.toRoute location
            in
                updateUrl { model | route = route }


updateUrl : Model -> ( Model, Cmd Msg )
updateUrl model =
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
        |> SurveyResultList.Commands.fetchSurveyResultList
        |> Cmd.map SurveyResultListMsg
