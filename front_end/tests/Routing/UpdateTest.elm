module Routing.UpdateTest exposing (updateTests)

import Expect
import Factory.Config as Config
import Factory.Navigation.Location as Location
import Model exposing (Model)
import Msg exposing (Msg(RoutingMsg))
import Routing.Msg exposing (Msg(ChangeLocation, OnLocationChange))
import Routing.Route exposing (Route(ListSurveyResultsRoute, NotFoundRoute))
import Test exposing (Test, describe, test)
import Update


updateTests : Test
updateTests =
    let
        model =
            Model.initialModel Config.factory NotFoundRoute
    in
        describe "update"
            [ test "updates the model route on ChangeLocation message" <|
                \() ->
                    let
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
