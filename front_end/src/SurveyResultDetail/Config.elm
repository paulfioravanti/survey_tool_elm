module SurveyResultDetail.Config exposing (Config)

import Locale


type alias Config msg =
    { backToHomeMsg : msg
    , backToHomePath : String
    , blurMsg : msg
    , localeMsg : Locale.Msg -> msg
    }
