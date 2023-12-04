module Language.AvailableLanguagesTest exposing (all)

import Expect
import Language exposing (Language)
import Test exposing (Test, describe, test)


all : Test
all =
    let
        expectedAvailableLanguages : List Language
        expectedAvailableLanguages =
            [ Language.En, Language.It, Language.Ja ]

        actualAvailableLanguages : List Language
        actualAvailableLanguages =
            Language.availableLanguages
    in
    describe "Language.availableLanguages"
        [ test "retuns a limited list of languages available in application" <|
            \() ->
                Expect.equal expectedAvailableLanguages actualAvailableLanguages
        ]
