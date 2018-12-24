module Language.AvailableLanguagesTest exposing (all)

import Expect
import Json.Encode exposing (null, string)
import Language
import Test exposing (Test, describe, test)


all : Test
all =
    let
        expectedAvailableLanguages =
            [ Language.En, Language.It, Language.Ja ]

        actualAvailableLanguages =
            Language.availableLanguages
    in
    describe "Language.availableLanguages"
        [ test "retuns a limited list of languages available in application" <|
            \() ->
                Expect.equal expectedAvailableLanguages actualAvailableLanguages
        ]
