module Language.ToStringTest exposing (all)

import Expect
import Json.Encode exposing (null, string)
import Language
import Test exposing (Test, describe, test)


all : Test
all =
    describe "Language.toString"
        [ toStringWithEnLanguageTest
        , toStringWithItLanguageTest
        , toStringWithJaLanguageTest
        ]


toStringWithEnLanguageTest : Test
toStringWithEnLanguageTest =
    let
        expectedString =
            "en"

        language =
            Language.En

        actualString =
            Language.toString language
    in
    describe "when given the En language"
        [ test "returns an 'en' string" <|
            \() ->
                Expect.equal expectedString actualString
        ]


toStringWithItLanguageTest : Test
toStringWithItLanguageTest =
    let
        expectedString =
            "it"

        language =
            Language.It

        actualString =
            Language.toString language
    in
    describe "when given the It language"
        [ test "returns an 'it' string" <|
            \() ->
                Expect.equal expectedString actualString
        ]


toStringWithJaLanguageTest : Test
toStringWithJaLanguageTest =
    let
        expectedString =
            "ja"

        language =
            Language.Ja

        actualString =
            Language.toString language
    in
    describe "when given the Ja language"
        [ test "returns a 'ja' string" <|
            \() ->
                Expect.equal expectedString actualString
        ]
