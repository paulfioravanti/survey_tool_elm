module Route.InitTest exposing (all)

import Expect
import Factory.Url as Factory
import Fuzz exposing (Fuzzer)
import Route exposing (Route)
import Test exposing (Test, describe, fuzz, test)
import Url exposing (Url)


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
        expectedRoute : Maybe Route
        expectedRoute =
            Just Route.SurveyResultList

        url : Url
        url =
            Factory.urlWithPath "/"

        actualRoute : Maybe Route
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
        expectedRoute : Maybe Route
        expectedRoute =
            Just Route.SurveyResultList

        url : Url
        url =
            Factory.urlWithPath "/survey_results/"

        actualRoute : Maybe Route
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
        randomId : Fuzzer Int
        randomId =
            Fuzz.int
    in
    describe "when given an url with the survey result detail path and an id"
        [ fuzz randomId "returns Just Route.SurveyResultDetail for the id" <|
            \intId ->
                let
                    id : String
                    id =
                        String.fromInt intId

                    expectedRoute : Maybe Route
                    expectedRoute =
                        Just (Route.SurveyResultDetail id)

                    url : Url
                    url =
                        Factory.urlWithPath ("/survey_results/" ++ id ++ "/")

                    actualRoute : Maybe Route
                    actualRoute =
                        Route.init url
                in
                Expect.equal expectedRoute actualRoute
        ]


initWithUnknownPathTest : Test
initWithUnknownPathTest =
    let
        expectedRoute : Maybe Route
        expectedRoute =
            Nothing

        url : Url
        url =
            Factory.urlWithPath "/unknown/"

        actualRoute : Maybe Route
        actualRoute =
            Route.init url
    in
    describe "when given an url with an unknown path"
        [ test "returns Nothing" <|
            \() ->
                Expect.equal expectedRoute actualRoute
        ]
