module Language.ToStringTest exposing (all)

import Expect
import Language exposing (Language)
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
        expectedString : String
        expectedString =
            "en"

        language : Language
        language =
            Language.En

        actualString : String
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
        expectedString : String
        expectedString =
            "it"

        language : Language
        language =
            Language.It

        actualString : String
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
        expectedString : String
        expectedString =
            "ja"

        language : Language
        language =
            Language.Ja

        actualString : String
        actualString =
            Language.toString language
    in
    describe "when given the Ja language"
        [ test "returns a 'ja' string" <|
            \() ->
                Expect.equal expectedString actualString
        ]
