module LanguageSelector.Model exposing
    ( LanguageSelector
    , init
    , updateSelectableLanguages
    )

import Language exposing (Language)


type alias LanguageSelector =
    { selectableLanguages : List Language
    , showSelectableLanguages : Bool
    }


init : Language -> LanguageSelector
init language =
    { selectableLanguages = selectableLanguages language
    , showSelectableLanguages = False
    }


updateSelectableLanguages : Language -> LanguageSelector -> LanguageSelector
updateSelectableLanguages language languageSelector =
    { languageSelector
        | selectableLanguages = selectableLanguages language
    }



-- PRIVATE


{-| The current language should be filtered out of the list of selectable
languages as there is no point in, for example, switching from English to
English.
-}
selectableLanguages : Language -> List Language
selectableLanguages currentLanguage =
    Language.availableLanguages
        |> List.filter
            (\availableLanguage -> availableLanguage /= currentLanguage)
