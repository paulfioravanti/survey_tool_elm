module LanguageSelector.HideSelectableLanguagesTest exposing (all)

import Expect
import LanguageSelector
import LanguageSelector.Msg as Msg
import Test exposing (Test, describe, test)


all : Test
all =
    describe "LanguageSelector.hideSelectableLanguages"
        [ let
            expectedData =
                Msg.HideSelectableLanguages

            actualData =
                LanguageSelector.hideSelectableLanguages
          in
          test "returns Msg.HideSelectableLanguages" <|
            \() ->
                Expect.equal expectedData actualData
        ]
