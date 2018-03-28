module Update exposing (update)

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

                model_ =
                    { model | route = route }
            in
                case route of
                    ListSurveyResultsRoute ->
                        case model_.surveyResultList of
                            NotRequested ->
                                ( { model_ | surveyResultList = Requesting }
                                , model_.config.apiUrl
                                    |> SurveyResultList.Commands.fetchSurveyResultList
                                    |> Cmd.map SurveyResultListMsg
                                )

                            _ ->
                                ( model_, Cmd.none )

                    _ ->
                        ( model, Cmd.none )



-- ( { model | route = route }, Cmd.map RoutingMsg cmd )
