module Theme exposing (Theme, decoder, view)

import Html.Styled exposing (Html)
import Json.Decode exposing (Decoder)
import Theme.Decoder as Decoder
import Theme.Model as Model
import Theme.View as View
import Translations exposing (Lang)


type alias Theme =
    Model.Theme


decoder : Decoder Theme
decoder =
    Decoder.decoder


view : msg -> Lang -> Theme -> Html msg
view blurMsg language theme =
    View.view blurMsg language theme
