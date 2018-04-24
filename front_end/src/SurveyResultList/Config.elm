module SurveyResultList.Config exposing (Config)

import Locale exposing (Language)


type alias Config msg =
    { changeLanguageMsg : Language -> msg
    , surveyResultDetailMsg : String -> msg
    }
