module Language.InitTest exposing (all)

import Expect
import Json.Encode exposing (Value, null, string)
import Language exposing (Language)
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
        expectedLanguage : Language
        expectedLanguage =
            Language.En

        flag : Value
        flag =
            string "en"

        actualLanguage : Language
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
        expectedLanguage : Language
        expectedLanguage =
            Language.It

        flag : Value
        flag =
            string "it"

        actualLanguage : Language
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
        expectedLanguage : Language
        expectedLanguage =
            Language.Ja

        flag : Value
        flag =
            string "ja"

        actualLanguage : Language
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
        expectedLanguage : Language
        expectedLanguage =
            Language.En

        flag : Value
        flag =
            null

        actualLanguage : Language
        actualLanguage =
            Language.init flag
    in
    describe "when given an invalid language flag"
        [ test "returns the default En language" <|
            \() ->
                Expect.equal expectedLanguage actualLanguage
        ]
