module SurveyResultList.Model exposing (Config, SurveyResultList)

import Locale exposing (Language)
import Route exposing (Route)
import SurveyResult exposing (SurveyResult)


type alias Config msg =
    { surveyResultDetailMsg : String -> msg
    , changeLanguageMsg : msg
    }


type alias SurveyResultList =
    { surveyResults : List SurveyResult
    }
