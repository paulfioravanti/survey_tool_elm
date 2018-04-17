module SurveyResultList.Model exposing (SurveyResultList)

import SurveyResult exposing (SurveyResult)


type alias SurveyResultList =
    { surveyResults : List SurveyResult
    }
