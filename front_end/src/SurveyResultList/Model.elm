module SurveyResultList.Model exposing (SurveyResultList)

import SurveyResult.Model exposing (SurveyResult)


type alias SurveyResultList =
    { surveyResults : List SurveyResult
    }
