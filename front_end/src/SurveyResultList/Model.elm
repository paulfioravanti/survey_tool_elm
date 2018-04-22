module SurveyResultList.Model exposing (Config, SurveyResultList)

import SurveyResult exposing (SurveyResult)


type alias Config msg =
    { surveyResultDetailMsg : String -> msg }


type alias SurveyResultList =
    { surveyResults : List SurveyResult
    }
