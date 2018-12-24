module Page.NotFound.TitleTest exposing (all)

import Expect
import Fuzz exposing (Fuzzer)
import Language exposing (Language)
import Language.Fuzzer as Language
import Page.NotFound as NotFound
import Test exposing (Test, describe, fuzz)
import Translations


all : Test
all =
    let
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
                expectedTitle =
                    Translations.notFound language

                actualTitle =
                    NotFound.title language
            in
            Expect.equal expectedTitle actualTitle
