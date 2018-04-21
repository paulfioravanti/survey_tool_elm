module SurveyResultDetail.Model exposing (Config)


type alias Config msg =
    { backToHomeMsg : msg
    , blurMsg : msg
    , path : String
    }
