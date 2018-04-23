module Locale.Utils exposing (languageToFlagClass)

import Locale.Model exposing (Language(En, It, Ja))


languageToFlagClass : Language -> String
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
