module Language.InitTest exposing (all)

import Expect
import Json.Encode exposing (null, string)
import Language
import Test exposing (Test, describe, test)


all : Test
all =
    describe "Language.init"
        [ initWithEnFlagTest
        , initWithItFlagTest
        , initWithJaFlagTest
        , initWithInvalidFlagTest
        ]


initWithEnFlagTest : Test
initWithEnFlagTest =
    let
        expectedLanguage =
            Language.En

        flag =
            string "en"

        actualLanguage =
            Language.init flag
    in
    describe "when given an 'en' string language flag"
        [ test "returns the En language" <|
            \() ->
                Expect.equal expectedLanguage actualLanguage
        ]


initWithItFlagTest : Test
initWithItFlagTest =
    let
        expectedLanguage =
            Language.It

        flag =
            string "it"

        actualLanguage =
            Language.init flag
    in
    describe "when given an 'it' string language flag"
        [ test "returns the It language" <|
            \() ->
                Expect.equal expectedLanguage actualLanguage
        ]


initWithJaFlagTest : Test
initWithJaFlagTest =
    let
        expectedLanguage =
            Language.Ja

        flag =
            string "ja"

        actualLanguage =
            Language.init flag
    in
    describe "when given a 'ja' string language flag"
        [ test "returns the Ja language" <|
            \() ->
                Expect.equal expectedLanguage actualLanguage
        ]


initWithInvalidFlagTest : Test
initWithInvalidFlagTest =
    let
        expectedLanguage =
            Language.En

        flag =
            null

        actualLanguage =
            Language.init flag
    in
    describe "when given an invalid language flag"
        [ test "returns the default En language" <|
            \() ->
                Expect.equal expectedLanguage actualLanguage
        ]
