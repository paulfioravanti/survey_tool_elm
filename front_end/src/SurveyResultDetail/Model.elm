module SurveyResultDetail.Model exposing (Config)

import Locale exposing (Language)


type alias Config msg =
    { backToHomeMsg : msg
    , blurMsg : msg
    , changeLanguageMsg : Language -> msg
    , path : String
    }
