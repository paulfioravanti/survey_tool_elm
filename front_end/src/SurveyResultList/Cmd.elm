module SurveyResultList.Cmd exposing (load)

import RemoteData exposing (WebData)
import SurveyResultList.Model exposing (SurveyResultList)
import SurveyResultList.Msg as Msg exposing (Msg)
import Task


load : String -> WebData SurveyResultList -> Cmd Msg
load apiUrl surveyResultList =
    surveyResultList
        |> Msg.Load apiUrl
        |> Task.succeed
        |> Task.perform identity
