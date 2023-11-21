module Language.ToFlagClassTest exposing (all)

import Expect
import Language
import Test exposing (Test, describe, test)


all : Test
all =
    describe "Language.toFlagClass"
        [ toFlagClassWithEnLanguageTest
        , toFlagClassWithItLanguageTest
        , toFlagClassWithJaLanguageTest
        ]


toFlagClassWithEnLanguageTest : Test
toFlagClassWithEnLanguageTest =
    let
        expectedFlagClass =
            "fi fi-au"

        language =
            Language.En

        actualFlagClass =
            Language.toFlagClass language
    in
    describe "when given the En language"
        [ test "returns the flag css class for the Australian flag" <|
            \() ->
                Expect.equal expectedFlagClass actualFlagClass
        ]


toFlagClassWithItLanguageTest : Test
toFlagClassWithItLanguageTest =
    let
        expectedFlagClass =
            "fi fi-it"

        language =
            Language.It

        actualFlagClass =
            Language.toFlagClass language
    in
    describe "when given the It language"
        [ test "returns the flag css class for the Italian flag" <|
            \() ->
                Expect.equal expectedFlagClass actualFlagClass
        ]


toFlagClassWithJaLanguageTest : Test
toFlagClassWithJaLanguageTest =
    let
        expectedFlagClass =
            "fi fi-jp"

        language =
            Language.Ja

        actualFlagClass =
            Language.toFlagClass language
    in
    describe "when given the Ja language"
        [ test "returns the flag css class for the Japanese flag" <|
            \() ->
                Expect.equal expectedFlagClass actualFlagClass
        ]
