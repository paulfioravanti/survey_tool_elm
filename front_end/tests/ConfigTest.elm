module ConfigTest exposing (suite)

import Config exposing (Config)
import Expect
import Flags exposing (Flags)
import Json.Encode as Encode
import Test exposing (Test, describe, test)


suite : Test
suite =
    describe "init"
        [ productionEnvironmentTest ()
        , environmentNotProvidedTest ()
        , otherEnvironmentWithApiUrlGivenTest ()
        , otherEnvironmentWithApiUrlNotGivenTest ()
        ]


productionEnvironmentTest : () -> Test
productionEnvironmentTest () =
    let
        flags =
            Flags
                (Encode.string "production")
                (Encode.string "http://localhost:4000/survey_results/")
                (Encode.string "en")

        config =
            Config
                "https://survey-tool-back-end.herokuapp.com/survey_results/"
    in
        describe "when environment is production"
            [ test "apiUrl is set to be the production url" <|
                \() ->
                    flags
                        |> Config.init
                        |> Expect.equal config
            ]


environmentNotProvidedTest : () -> Test
environmentNotProvidedTest () =
    let
        flags =
            Flags
                (Encode.null)
                (Encode.string "http://localhost:4000/survey_results/")
                (Encode.string "en")

        config =
            Config
                "https://survey-tool-back-end.herokuapp.com/survey_results/"
    in
        describe "when environment is not provided"
            [ test "apiUrl is set to be the production url" <|
                \() ->
                    flags
                        |> Config.init
                        |> Expect.equal config
            ]


otherEnvironmentWithApiUrlGivenTest : () -> Test
otherEnvironmentWithApiUrlGivenTest () =
    let
        apiUrl =
            "http://example.com/survey_results/"

        apiUrlFlag =
            Encode.string apiUrl

        flags =
            Flags
                (Encode.string "someEnvironment")
                apiUrlFlag
                (Encode.string "en")

        config =
            Config apiUrl
    in
        describe "when environment is not production and apiUrl given"
            [ test "apiUrl is set to be the given url" <|
                \() ->
                    flags
                        |> Config.init
                        |> Expect.equal config
            ]


otherEnvironmentWithApiUrlNotGivenTest : () -> Test
otherEnvironmentWithApiUrlNotGivenTest () =
    let
        -- If no value is given for the apiUrl flag, then this will be
        -- undefined, but inserting null will make the decoding fail in the
        -- same way that is desired to fall back to the default apiUrl value.
        flags =
            Flags
                (Encode.string "someEnvironment")
                Encode.null
                (Encode.string "en")

        config =
            Config "http://localhost:4000/survey_results/"
    in
        describe "when environment is not production and apiUrl not given"
            [ test "apiUrl is set to be the localhost url" <|
                \() ->
                    flags
                        |> Config.init
                        |> Expect.equal config
            ]
