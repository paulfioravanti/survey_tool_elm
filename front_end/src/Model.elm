module Model exposing (Model, initialModel)

import Config exposing (Config)
import RemoteData exposing (RemoteData(NotRequested), WebData)
import SurveyResultList.Model exposing (SurveyResultList)


type alias Model =
    { surveyResultList : WebData SurveyResultList
    , config : Config
    }


initialModel : Config -> Model
initialModel config =
    { surveyResultList = NotRequested
    , config = config
    }
