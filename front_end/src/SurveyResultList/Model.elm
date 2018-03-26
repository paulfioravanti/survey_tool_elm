module SurveyResultList.Model exposing (SurveyResultList, initialSurveyResultList)

import SurveyResult.Model exposing (SurveyResult)


type alias SurveyResultList =
    { surveyResults : List SurveyResult
    }


initialSurveyResultList : SurveyResultList
initialSurveyResultList =
    { surveyResults =
        [ SurveyResult
            "Test"
            6
            0.83
            5
            "/survey_results/1"
        , SurveyResult
            "Some other test"
            271
            1.0
            271
            "/survey_results/2"
        ]
    }
