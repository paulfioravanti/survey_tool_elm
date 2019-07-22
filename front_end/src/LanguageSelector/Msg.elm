module LanguageSelector.Msg exposing
    ( Msg(..)
    , hideSelectableLanguages
    , toggleSelectableLanguages
    )


type Msg
    = HideSelectableLanguages
    | ToggleSelectableLanguages


hideSelectableLanguages : (Msg -> msg) -> msg
hideSelectableLanguages languageSelectorMsg =
    languageSelectorMsg HideSelectableLanguages


toggleSelectableLanguages : (Msg -> msg) -> msg
toggleSelectableLanguages languageSelectorMsg =
    languageSelectorMsg ToggleSelectableLanguages
