module Language.ToFlagClassTest exposing (all)

import Expect
import Language exposing (Language)
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
        expectedFlagClass : String
        expectedFlagClass =
            "fi fi-au"

        language : Language
        language =
            Language.En

        actualFlagClass : String
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
        expectedFlagClass : String
        expectedFlagClass =
            "fi fi-it"

        language : Language
        language =
            Language.It

        actualFlagClass : String
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
        expectedFlagClass : String
        expectedFlagClass =
            "fi fi-jp"

        language : Language
        language =
            Language.Ja

        actualFlagClass : String
        actualFlagClass =
            Language.toFlagClass language
    in
    describe "when given the Ja language"
        [ test "returns the flag css class for the Japanese flag" <|
            \() ->
                Expect.equal expectedFlagClass actualFlagClass
        ]
