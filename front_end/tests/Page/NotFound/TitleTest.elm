module Page.NotFound.TitleTest exposing (all)

import Expect
import Fuzz exposing (Fuzzer)
import Fuzzer.Language as Language
import Language exposing (Language)
import Page.NotFound as NotFound
import Test exposing (Test, describe, fuzz)
import Translations


all : Test
all =
    let
        randomLanguage : Fuzzer Language
        randomLanguage =
            Language.fuzzer
    in
    describe "Page.NotFound.title"
        [ titleTest randomLanguage
        ]


titleTest : Fuzzer Language -> Test
titleTest randomLanguage =
    fuzz randomLanguage "displays the title for the given language" <|
        \language ->
            let
                expectedTitle : String
                expectedTitle =
                    Translations.notFound language

                actualTitle : String
                actualTitle =
                    NotFound.title language
            in
            Expect.equal expectedTitle actualTitle
