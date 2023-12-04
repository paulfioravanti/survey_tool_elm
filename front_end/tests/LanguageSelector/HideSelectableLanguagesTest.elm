module LanguageSelector.HideSelectableLanguagesTest exposing (all)

import Expect
import LanguageSelector
import LanguageSelector.Msg
import Msg exposing (Msg)
import Test exposing (Test, describe, test)


all : Test
all =
    describe "LanguageSelector.hideSelectableLanguages"
        [ let
            expectedData : Msg
            expectedData =
                Msg.LanguageSelector
                    LanguageSelector.Msg.HideSelectableLanguages

            actualData : Msg
            actualData =
                LanguageSelector.hideSelectableLanguages Msg.LanguageSelector
          in
          test "returns Msg.HideSelectableLanguages" <|
            \() ->
                Expect.equal expectedData actualData
        ]
