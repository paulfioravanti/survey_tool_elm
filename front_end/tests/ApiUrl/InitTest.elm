module ApiUrl.InitTest exposing (all)

import ApiUrl
import Expect
import Flags exposing (Flags)
import Flags.Factory as Factory
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
        expectedApiUrl : String
        expectedApiUrl =
            "https://raw.githubusercontent.com/paulfioravanti/survey_tool_elm/master/back_end/lib/back_end/survey_results/"

        flags : Flags
        flags =
            Factory.emptyFlags

        actualApiUrl : String
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
        expectedApiUrl : String
        expectedApiUrl =
            "www.example.com/endpoint"

        flags : Flags
        flags =
            Factory.flagsWithApiUrl expectedApiUrl

        actualApiUrl : String
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
        expectedApiUrl : String
        expectedApiUrl =
            "http://localhost:4000/survey_results/"

        flags : Flags
        flags =
            Factory.flagsWithEnvironment "development"

        actualApiUrl : String
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
        expectedApiUrl : String
        expectedApiUrl =
            "https://raw.githubusercontent.com/paulfioravanti/survey_tool_elm/master/back_end/lib/back_end/survey_results/"

        flags : Flags
        flags =
            Factory.flagsWithEnvironment "production"

        actualApiUrl : String
        actualApiUrl =
            ApiUrl.init flags
    in
    describe "when flags are for production env but do not have an api url"
        [ test "returns the default api url for production environment" <|
            \() ->
                Expect.equal expectedApiUrl actualApiUrl
        ]
