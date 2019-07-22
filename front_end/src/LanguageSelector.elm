module LanguageSelector exposing
    ( LanguageSelector
    , Msg
    , hideSelectableLanguages
    , init
    , update
    , updateSelectableLanguages
    , view
    )

import Html.Styled exposing (Html)
import Language exposing (Language)
import LanguageSelector.Model as Model exposing (LanguageSelector)
import LanguageSelector.Msg as Msg
import LanguageSelector.Update as Update
import LanguageSelector.View as View


type alias LanguageSelector =
    Model.LanguageSelector


type alias Msg =
    Msg.Msg


init : Language -> LanguageSelector
init language =
    Model.init language


hideSelectableLanguages : (Msg -> msg) -> msg
hideSelectableLanguages languageSelectorMsg =
    Msg.hideSelectableLanguages languageSelectorMsg


update : Msg -> LanguageSelector -> LanguageSelector
update msg languageSelector =
    Update.update msg languageSelector


updateSelectableLanguages : Language -> LanguageSelector -> LanguageSelector
updateSelectableLanguages language languageSelector =
    Model.updateSelectableLanguages language languageSelector


view :
    (Language -> msg)
    -> (Msg -> msg)
    -> Language
    -> LanguageSelector
    -> Html msg
view changeLanguageMsg languageSelectorMsg language languageSelector =
    View.view changeLanguageMsg languageSelectorMsg language languageSelector
