module Model exposing (Model, initialModel)

import SurveyResultList.Model exposing (SurveyResultList, initialSurveyResultList)


type alias Model =
    { surveyResultList : SurveyResultList
    }


initialModel : Model
initialModel =
    { surveyResultList = initialSurveyResultList
    }
