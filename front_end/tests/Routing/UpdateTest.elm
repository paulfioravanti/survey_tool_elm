module Routing.UpdateTest exposing (updateTests)

import Expect
import Config.Fuzzer as Config
import Factory.Navigation.Location as Location
import Model exposing (Model)
import Msg exposing (Msg(RoutingMsg))
import Routing.Msg exposing (Msg(ChangeLocation, OnLocationChange))
import Routing.Route exposing (Route(ListSurveyResultsRoute, NotFoundRoute))
import Test exposing (Test, describe, fuzz)
import Update


updateTests : Test
updateTests =
    let
        config =
            Config.fuzzer
    in
        describe "update"
            [ fuzz config "updates the model route on ChangeLocation message" <|
                \config ->
                    let
                        model =
                            Model.initialModel config NotFoundRoute

                        msg =
                            RoutingMsg (ChangeLocation ListSurveyResultsRoute)
                    in
                        model
                            |> Update.update msg
                            |> Tuple.first
                            |> Expect.equal
                                { model | route = ListSurveyResultsRoute }
            , fuzz
                config
                "updates the model route on OnLocationChange message"
              <|
                \config ->
                    let
                        model =
                            Model.initialModel config NotFoundRoute

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
