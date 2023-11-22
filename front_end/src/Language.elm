module Language exposing
    ( Language(..)
    , availableLanguages
    , init
    , toFlagClass
    , toString
    )

import Json.Decode as Decode exposing (Error, Value)


type Language
    = En
    | It
    | Ja


{-| Converts language value from Flags into a Language

    import Json.Encode exposing (null, string)
    import Language

    init (string "en")
    --> Language.En

    init (string "it")
    --> Language.It

    init (string "ja")
    --> Language.Ja

    init null
    --> Language.En

-}
init : Value -> Language
init languageFlag =
    let
        language : Result Error String
        language =
            Decode.decodeValue Decode.string languageFlag
    in
    case language of
        Ok "en" ->
            En

        Ok "it" ->
            It

        Ok "ja" ->
            Ja

        _ ->
            En


availableLanguages : List Language
availableLanguages =
    [ En, It, Ja ]


toFlagClass : Language -> String
toFlagClass language =
    let
        flagIconLanguage : String
        flagIconLanguage =
            case language of
                En ->
                    "au"

                It ->
                    "it"

                Ja ->
                    "jp"
    in
    -- NOTE: Class name determined by the `flag-icon-css` Javascript library.
    "fi fi-" ++ flagIconLanguage


toString : Language -> String
toString language =
    case language of
        En ->
            "en"

        It ->
            "it"

        Ja ->
            "ja"
