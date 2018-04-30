module Header exposing (view)

import Html.Styled exposing (Html, nav)
import Html.Styled.Attributes exposing (class)
import Locale exposing (Locale)


view : (Locale.Msg -> msg) -> Locale -> Html msg
view localeMsg locale =
    let
        classes =
            [ "center"
            , "flex"
            , "flex-row-reverse"
            , "mt1"
            , "mw8"
            ]
                |> String.join " "
                |> class
    in
        nav [ classes ]
            [ Locale.dropdown localeMsg locale ]
