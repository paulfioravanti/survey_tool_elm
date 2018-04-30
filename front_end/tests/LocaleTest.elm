module LocaleTest exposing (suite)

import Expect
import I18Next
import Json.Encode as Encode
import Locale
import Locale.Model exposing (Language(En, Ja), Locale)
import Test exposing (Test, describe, test)


suite : Test
suite =
    describe "Locale"
        [ initTests () ]


initTests : () -> Test
initTests () =
    describe "init"
        [ describe "when language flag is invalid"
            [ test "sets the language to English as a default" <|
                \() ->
                    let
                        languageFlag =
                            Encode.null

                        locale =
                            Locale
                                En
                                False
                                I18Next.initialTranslations
                    in
                        languageFlag
                            |> Locale.init
                            |> Expect.equal locale
            ]
        , describe "when language flag is an English locale"
            [ test "sets the language to English" <|
                \() ->
                    let
                        languageFlag =
                            Encode.string "en-US"

                        locale =
                            Locale
                                En
                                False
                                I18Next.initialTranslations
                    in
                        languageFlag
                            |> Locale.init
                            |> Expect.equal locale
            ]
        , describe "when language flag is a Japanese locale"
            [ test "sets the language to Japanese" <|
                \() ->
                    let
                        languageFlag =
                            Encode.string "ja-JP"

                        locale =
                            Locale
                                Ja
                                False
                                I18Next.initialTranslations
                    in
                        languageFlag
                            |> Locale.init
                            |> Expect.equal locale
            ]
        , describe "when language flag is an unknown locale"
            [ test "sets the language to English" <|
                \() ->
                    let
                        languageFlag =
                            Encode.string "unknown"

                        locale =
                            Locale
                                En
                                False
                                I18Next.initialTranslations
                    in
                        languageFlag
                            |> Locale.init
                            |> Expect.equal locale
            ]
        ]
