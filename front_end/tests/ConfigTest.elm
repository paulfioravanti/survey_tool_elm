module ConfigTest exposing (suite)

import Config exposing (Config)
import Expect
import Flags exposing (Flags)
import Test exposing (Test, describe, test)


suite : Test
suite =
    describe "init"
        [ productionEnvironmentTest ()
        , otherEnvironmentTest ()
        ]


productionEnvironmentTest : () -> Test
productionEnvironmentTest () =
    let
        flags =
            Flags "production"

        config =
            Config "https://survey-tool-back-end.herokuapp.com/survey_results"
    in
        describe "when running environment is production"
            [ test "apiUrl is set to be the production url" <|
                \() ->
                    flags
                        |> Config.init
                        |> Expect.equal config
            ]


otherEnvironmentTest : () -> Test
otherEnvironmentTest () =
    let
        flags =
            Flags "someEnvironment"

        config =
            Config "http://localhost:4000/survey_results"
    in
        describe "when running environment is not production"
            [ test "apiUrl is set to be the localhost url" <|
                \() ->
                    flags
                        |> Config.init
                        |> Expect.equal config
            ]
