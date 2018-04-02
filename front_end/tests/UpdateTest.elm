module UpdateTest exposing (..)

import Expect
import Factory.Config as Config
import Factory.Navigation.Location as Location
import Model exposing (Model)
import Msg exposing (Msg(SurveyResultListMsg, RoutingMsg, UpdatePage))
import Routing.Msg exposing (Msg(ChangeLocation, OnLocationChange))
import Routing.Route exposing (Route(ListSurveyResultsRoute, NotFoundRoute))
import Test exposing (Test, describe, test)
import Update


updateTests : Test
updateTests =
    describe "update"
        [ test "updates the model route on ChangeLocation message" <|
            \() ->
                let
                    model =
                        Model.initialModel Config.factory NotFoundRoute

                    msg =
                        RoutingMsg (ChangeLocation ListSurveyResultsRoute)
                in
                    model
                        |> Update.update msg
                        |> Tuple.first
                        |> Expect.equal
                            { model | route = ListSurveyResultsRoute }
        , test "updates the model route on OnLocationChange message" <|
            \() ->
                let
                    model =
                        Model.initialModel Config.factory NotFoundRoute

                    location =
                        Location.factory "/survey_results"

                    msg =
                        RoutingMsg (OnLocationChange location)
                in
                    model
                        |> Update.update msg
                        |> Tuple.first
                        |> Expect.equal
                            { model | route = ListSurveyResultsRoute }
        ]
