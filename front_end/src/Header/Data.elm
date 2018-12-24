module Header.Data exposing (view)

{-| Content for the Header at the top of pages that contain survey data.
-}

import Header.View as View
import Html.Styled exposing (Html, text)
import Language exposing (Language)
import LanguageSelector exposing (LanguageSelector)
import RemoteData exposing (WebData)


{-| The header should only display if there is data that can be displayed
on the screen successfully: if there is no data, remote data is loading,
or there was a failure in loading the remote data.
-}
view :
    (Language -> msg)
    -> (LanguageSelector.Msg -> msg)
    -> Language
    -> LanguageSelector
    -> WebData a
    -> Html msg
view changeLanguageMsg languageSelectorMsg language languageSelector webData =
    case webData of
        RemoteData.Success _ ->
            View.view
                changeLanguageMsg
                languageSelectorMsg
                language
                languageSelector

        _ ->
            text ""
