module SurveyResultList.Config exposing (Config)

import Locale
import Navigation exposing (Location)


type alias Config msg =
    { localeMsg : Locale.Msg -> msg
    , surveyResultDetailMsg : String -> msg
    , updatePageMsg : Location -> msg
    }
