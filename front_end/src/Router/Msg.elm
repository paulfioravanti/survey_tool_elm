module Router.Msg exposing (Msg(..))

import Locale exposing (Language)
import Route exposing (Route)


type Msg
    = Blur Route
    | ChangeLanguage Route Language
    | ChangeLocation Route
