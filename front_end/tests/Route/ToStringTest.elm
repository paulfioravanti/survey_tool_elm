module Route.ToStringTest exposing (all)

import Expect
import Fuzz
import Route
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
        expectedString =
            "/survey_results/"

        route =
            Route.SurveyResultList

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
        randomId =
            Fuzz.int
    in
    describe "when given the SurveyResultDetail route with an id"
        [ fuzz randomId "returns '/survey_results/:id'" <|
            \intId ->
                let
                    id =
                        String.fromInt intId

                    expectedString =
                        "/survey_results/" ++ id ++ "/"

                    route =
                        Route.SurveyResultDetail id

                    actualString =
                        Route.toString route
                in
                Expect.equal expectedString actualString
        ]
