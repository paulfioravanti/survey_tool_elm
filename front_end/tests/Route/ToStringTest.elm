module Route.ToStringTest exposing (all)

import Expect
import Fuzz exposing (Fuzzer)
import Route exposing (Route)
import Test exposing (Test, describe, fuzz, test)


all : Test
all =
    describe "Router.toString"
        [ toStringWithSurveyResultListRouteTest
        , toStringWithSurveyResultDetailRouteTest
        ]


toStringWithSurveyResultListRouteTest : Test
toStringWithSurveyResultListRouteTest =
    let
        expectedString : String
        expectedString =
            "/survey_results/"

        route : Route
        route =
            Route.SurveyResultList

        actualString : String
        actualString =
            Route.toString route
    in
    describe "when given the SurveyResultList route"
        [ test "returns '/survey_results/'" <|
            \() ->
                Expect.equal expectedString actualString
        ]


toStringWithSurveyResultDetailRouteTest : Test
toStringWithSurveyResultDetailRouteTest =
    let
        randomId : Fuzzer Int
        randomId =
            Fuzz.int
    in
    describe "when given the SurveyResultDetail route with an id"
        [ fuzz randomId "returns '/survey_results/:id'" <|
            \intId ->
                let
                    id : String
                    id =
                        String.fromInt intId

                    expectedString : String
                    expectedString =
                        "/survey_results/" ++ id ++ "/"

                    route : Route
                    route =
                        Route.SurveyResultDetail id

                    actualString : String
                    actualString =
                        Route.toString route
                in
                Expect.equal expectedString actualString
        ]
