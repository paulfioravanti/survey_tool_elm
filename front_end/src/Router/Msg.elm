module Router.Msg exposing (Msg(..))

import Locale exposing (Language)
import Navigation exposing (Location)
import Route exposing (Route)


type Msg
    = Blur Route
    | ChangeLanguage Route Language
    | ChangeLocation Route
    | LocationChanged Location
