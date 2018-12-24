module LanguageSelector.Update exposing (update)

import LanguageSelector.Model exposing (LanguageSelector)
import LanguageSelector.Msg as Msg exposing (Msg)


update : Msg -> LanguageSelector -> LanguageSelector
update msg languageSelector =
    case msg of
        Msg.HideSelectableLanguages ->
            { languageSelector | showSelectableLanguages = False }

        Msg.ToggleSelectableLanguages ->
            { languageSelector
                | showSelectableLanguages =
                    not languageSelector.showSelectableLanguages
            }
