module Routing.UpdateTest exposing (updateTests)

import Expect
import Fuzzer.Config as Config
import Fuzzer.Navigation.Location as Location
import Model exposing (Model)
import Msg exposing (Msg(RoutingMsg))
import Routing.Msg exposing (Msg(ChangeLocation, OnLocationChange))
import Routing.Route exposing (Route(ListSurveyResultsRoute, NotFoundRoute))
import Test exposing (Test, describe, fuzz, fuzz2)
import Update


updateTests : Test
updateTests =
    let
        config =
            Config.fuzzer

        location =
            Location.fuzzer "/survey_results"
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
            , fuzz2
                config
                location
                "updates the model route on OnLocationChange message"
              <|
                \config location ->
                    let
                        model =
                            Model.initialModel config NotFoundRoute

                        msg =
                            RoutingMsg (OnLocationChange location)
                    in
                        model
                            |> Update.update msg
                            |> Tuple.first
                            |> Expect.equal
                                { model | route = ListSurveyResultsRoute }
            ]
