module SurveyResultDetail.Config exposing (Config)

import Locale
import Navigation exposing (Location)


type alias Config msg =
    { backToHomeMsg : msg
    , blurMsg : msg
    , localeMsg : Locale.Msg -> msg
    , path : String
    }
