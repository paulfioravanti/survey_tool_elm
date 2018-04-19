module Theme exposing (Theme, decoder, view)

import Html.Styled exposing (Html)
import I18Next exposing (Translations)
import Json.Decode as Decode
import Theme.Decoder as Decoder
import Theme.Model as Model
import Theme.View as View


type alias Theme =
    Model.Theme


decoder : Decode.Decoder Theme
decoder =
    Decoder.decoder


view : Translations -> Theme -> Html msg
view translations theme =
    View.view translations theme
