module SurveyResultList.Config exposing (Config)

import Locale


type alias Config msg =
    { blurMsg : msg
    , localeMsg : Locale.Msg -> msg
    , surveyResultDetailMsg : String -> msg
    }
