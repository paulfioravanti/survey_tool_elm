module SurveyResultDetail.Config exposing (Config)

import Locale


type alias Config msg =
    { backToHomeMsg : msg
    , blurMsg : msg
    , changeLanguageMsg : Locale.Msg -> msg
    , path : String
    }
