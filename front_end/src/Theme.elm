module Theme exposing (Theme, decoder, view)

import Html.Styled exposing (Html)
import I18Next exposing (Translations)
import Json.Decode as Decode exposing (Decoder)
import Theme.Decoder as Decoder
import Theme.Model as Model
import Theme.View as View
import SurveyResultDetail.Config exposing (Config)


type alias Theme =
    Model.Theme


decoder : Decoder Theme
decoder =
    Decoder.decoder


view : Config msg -> Translations -> Theme -> Html msg
view config translations theme =
    View.view config translations theme
