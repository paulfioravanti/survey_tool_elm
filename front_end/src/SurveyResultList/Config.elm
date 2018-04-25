module SurveyResultList.Config exposing (Config)

import Locale


type alias Config msg =
    { changeLanguageMsg : Locale.Msg -> msg
    , surveyResultDetailMsg : String -> msg
    }
