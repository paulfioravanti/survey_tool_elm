module LocaleTest exposing (suite)

import Expect
import Json.Encode as Encode
import Locale
import Locale.Model exposing (Locale)
import Test exposing (Test, describe, test)
import Translations exposing (Lang(En, It, Ja))


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
                    in
                        languageFlag
                            |> Locale.init
                            |> Expect.equal locale
            ]
        , describe "when language flag is an Italian locale"
            [ test "sets the language to Italian" <|
                \() ->
                    let
                        languageFlag =
                            Encode.string "it"

                        locale =
                            Locale
                                It
                                False
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
                    in
                        languageFlag
                            |> Locale.init
                            |> Expect.equal locale
            ]
        ]
