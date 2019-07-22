module LanguageSelector.HideSelectableLanguagesTest exposing (all)

import Expect
import LanguageSelector
import LanguageSelector.Msg
import Msg
import Test exposing (Test, describe, test)


all : Test
all =
    describe "LanguageSelector.hideSelectableLanguages"
        [ let
            expectedData =
                Msg.LanguageSelector
                    LanguageSelector.Msg.HideSelectableLanguages

            actualData =
                LanguageSelector.hideSelectableLanguages Msg.LanguageSelector
          in
          test "returns Msg.HideSelectableLanguages" <|
            \() ->
                Expect.equal expectedData actualData
        ]
