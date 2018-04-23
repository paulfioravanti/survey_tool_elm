module SurveyResultList.Model exposing (Config, SurveyResultList)

import Locale exposing (Language)
import SurveyResult exposing (SurveyResult)


type alias Config msg =
    { surveyResultDetailMsg : String -> msg
    , changeLanguageMsg : Language -> msg
    }


type alias SurveyResultList =
    { surveyResults : List SurveyResult }
