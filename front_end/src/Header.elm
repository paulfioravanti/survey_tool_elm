module Header exposing (view)

import Html.Styled exposing (Html, nav)
import Html.Styled.Attributes exposing (class)
import Locale exposing (Locale)


view : (Locale.Msg -> msg) -> Locale -> Html msg
view localeMsg locale =
    nav [ class "flex flex-row-reverse mw8 center mt1" ]
        [ Locale.dropdown localeMsg locale ]
