module Model exposing (Model, initialModel)

import RemoteData exposing (RemoteData(NotRequested), WebData)
import SurveyResultList.Model exposing (SurveyResultList)


type alias Model =
    { surveyResultList : WebData SurveyResultList
    }


initialModel : Model
initialModel =
    { surveyResultList = NotRequested
    }
