module Main.MainTest exposing (all)

import Expect
import Main
import Test exposing (Test, describe, test)


all : Test
all =
    -- This test is really just a litmus test and to register this function as
    -- being tested in elm-coverage
    describe "Main.main"
        [ test "runs the program" <|
            \() ->
                let
                    _ =
                        Main.main
                in
                Expect.pass
        ]
