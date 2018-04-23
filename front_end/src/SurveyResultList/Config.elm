module SurveyResultList.Config exposing (Config)

import Locale exposing (Language)


type alias Config msg =
    { surveyResultDetailMsg : String -> msg
    , changeLanguageMsg : Language -> msg
    }
