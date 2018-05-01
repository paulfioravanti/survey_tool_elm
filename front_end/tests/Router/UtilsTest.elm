module Router.UtilsTest exposing (suite)

import Expect
import Fuzz exposing (Fuzzer)
import Fuzzer.Navigation.Location as Location
import Route exposing (Route(ListSurveyResultsRoute, NotFoundRoute))
import Router.Utils as Utils
import Test exposing (Test, describe, fuzz, test)


suite : Test
suite =
    describe "Router.Utils"
        [ toRouteTests () ]


toRouteTests : () -> Test
toRouteTests () =
    let
        location =
            Location.fuzzer
    in
        describe "toRoute"
            [ describe "when location path is valid"
                [ fuzz location "returns a valid route" <|
                    \location ->
                        let
                            validLocation =
                                { location | pathname = "/survey_results" }
                        in
                            validLocation
                                |> Utils.toRoute
                                |> Expect.equal ListSurveyResultsRoute
                ]
            , describe "when location path is invalid"
                [ fuzz location "returns NotFoundRoute" <|
                    \location ->
                        let
                            invalidLocation =
                                { location | pathname = "/not-valid-at-all" }
                        in
                            invalidLocation
                                |> Utils.toRoute
                                |> Expect.equal NotFoundRoute
                ]
            ]
