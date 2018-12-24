module SurveyResult.Cmd exposing (load)

import RemoteData exposing (WebData)
import SurveyResult.Model exposing (SurveyResult)
import SurveyResult.Msg as Msg exposing (Msg)
import Task


load : String -> String -> WebData SurveyResult -> Cmd Msg
load apiUrl id surveyResult =
    surveyResult
        |> Msg.Load apiUrl id
        |> Task.succeed
        |> Task.perform identity
