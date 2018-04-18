module Theme exposing (Theme, decoder, view)

import Html.Styled exposing (Html)
import Json.Decode as Decode
import Theme.Decoder as Decoder
import Theme.Model as Model
import Theme.View as View


type alias Theme =
    Model.Theme


decoder : Decode.Decoder Theme
decoder =
    Decoder.decoder


view : Theme -> Html msg
view theme =
    View.view theme
