module Route.InitTest exposing (all)

import Expect
import Fuzz
import Route
import Test exposing (Test, describe, fuzz, test)
import Url.Factory as Factory


all : Test
all =
    describe "Router.init"
        [ initWithRootPathTest
        , initWithSurveyResultListPathTest
        , initWithSurveyResultDetailPathTest
        , initWithUnknownPathTest
        ]


initWithRootPathTest : Test
initWithRootPathTest =
    let
        expectedRoute =
            Just Route.SurveyResultList

        url =
            Factory.urlWithPath "/"

        actualRoute =
            Route.init url
    in
    describe "when given an url with the root path"
        [ test "returns Just Route.SurveyResultList" <|
            \() ->
                Expect.equal expectedRoute actualRoute
        ]


initWithSurveyResultListPathTest : Test
initWithSurveyResultListPathTest =
    let
        expectedRoute =
            Just Route.SurveyResultList

        url =
            Factory.urlWithPath "/survey_results/"

        actualRoute =
            Route.init url
    in
    describe "when given an url with the survey result list path"
        [ test "returns Just Route.SurveyResultList" <|
            \() ->
                Expect.equal expectedRoute actualRoute
        ]


initWithSurveyResultDetailPathTest : Test
initWithSurveyResultDetailPathTest =
    let
        randomId =
            Fuzz.int
    in
    describe "when given an url with the survey result detail path and an id"
        [ fuzz randomId "returns Just Route.SurveyResultDetail for the id" <|
            \intId ->
                let
                    id =
                        String.fromInt intId

                    expectedRoute =
                        Just (Route.SurveyResultDetail id)

                    url =
                        Factory.urlWithPath ("/survey_results/" ++ id ++ "/")

                    actualRoute =
                        Route.init url
                in
                Expect.equal expectedRoute actualRoute
        ]


initWithUnknownPathTest : Test
initWithUnknownPathTest =
    let
        expectedRoute =
            Nothing

        url =
            Factory.urlWithPath "/unknown/"

        actualRoute =
            Route.init url
    in
    describe "when given an url with an unknown path"
        [ test "returns Nothing" <|
            \() ->
                Expect.equal expectedRoute actualRoute
        ]
