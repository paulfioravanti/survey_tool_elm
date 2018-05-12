module Locale.Utils exposing (languageToFlagClass)

import Translations exposing (Lang(En, It, Ja))


languageToFlagClass : Lang -> String
languageToFlagClass language =
    let
        flagIconLanguage =
            case language of
                En ->
                    "au"

                It ->
                    "it"

                Ja ->
                    "jp"
    in
        "flag-icon flag-icon-" ++ flagIconLanguage
