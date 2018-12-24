module Theme exposing (Theme, decoder, view)

import Html.Styled exposing (Html)
import Json.Decode exposing (Decoder)
import Language exposing (Language)
import Theme.Decoder as Decoder
import Theme.Model as Model
import Theme.View as View


type alias Theme =
    Model.Theme


decoder : Decoder Theme
decoder =
    Decoder.decoder


view : Language -> Theme -> Html msg
view language theme =
    View.view language theme
