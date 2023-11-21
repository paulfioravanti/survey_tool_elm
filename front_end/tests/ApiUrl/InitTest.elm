module ApiUrl.InitTest exposing (all)

import ApiUrl
import Expect
import Flags.Factory as Factory
import Json.Encode exposing (null, string)
import Test exposing (Test, describe, test)


all : Test
all =
    describe "ApiUrl.init"
        [ initWithEmptyFlagsTest
        , initWithApiUrlTest
        , initforDevelopmentEnvWithoutApiUrlTest
        , initforProductionEnvWithoutApiUrlTest
        ]


initWithEmptyFlagsTest : Test
initWithEmptyFlagsTest =
    let
        expectedApiUrl =
            "https://raw.githubusercontent.com/paulfioravanti/survey_tool_elm/"
                ++ "master/back_end/lib/back_end/survey_results/"

        flags =
            Factory.emptyFlags

        actualApiUrl =
            ApiUrl.init flags
    in
    describe "when flags are empty"
        [ test "returns the default api url for production environment" <|
            \() ->
                Expect.equal expectedApiUrl actualApiUrl
        ]


initWithApiUrlTest : Test
initWithApiUrlTest =
    let
        expectedApiUrl =
            "www.example.com/endpoint"

        flags =
            Factory.flagsWithApiUrl expectedApiUrl

        actualApiUrl =
            ApiUrl.init flags
    in
    describe "when flags contain an api url flag"
        [ test "returns the api url flag" <|
            \() ->
                Expect.equal expectedApiUrl actualApiUrl
        ]


initforDevelopmentEnvWithoutApiUrlTest : Test
initforDevelopmentEnvWithoutApiUrlTest =
    let
        expectedApiUrl =
            "http://localhost:4000/survey_results/"

        flags =
            Factory.flagsWithEnvironment "development"

        actualApiUrl =
            ApiUrl.init flags
    in
    describe "when flags are for development env but do not have an api url"
        [ test "returns the default api url for development environment" <|
            \() ->
                Expect.equal expectedApiUrl actualApiUrl
        ]


initforProductionEnvWithoutApiUrlTest : Test
initforProductionEnvWithoutApiUrlTest =
    let
        expectedApiUrl =
            "https://raw.githubusercontent.com/paulfioravanti/survey_tool_elm/"
                ++ "master/back_end/lib/back_end/survey_results/"

        flags =
            Factory.flagsWithEnvironment "production"

        actualApiUrl =
            ApiUrl.init flags
    in
    describe "when flags are for production env but do not have an api url"
        [ test "returns the default api url for production environment" <|
            \() ->
                Expect.equal expectedApiUrl actualApiUrl
        ]
