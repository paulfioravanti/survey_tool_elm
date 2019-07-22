module SurveyResultList.Cmd exposing (load)

import RemoteData exposing (WebData)
import SurveyResultList.Model exposing (SurveyResultList)
import SurveyResultList.Msg as Msg exposing (Msg)
import Task


load : String -> WebData SurveyResultList -> Cmd Msg
load apiUrl surveyResultList =
    Msg.load apiUrl surveyResultList
        |> Task.succeed
        |> Task.perform identity
