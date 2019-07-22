module SurveyResult.Cmd exposing (load)

import RemoteData exposing (WebData)
import SurveyResult.Model exposing (SurveyResult)
import SurveyResult.Msg as Msg exposing (Msg)
import Task


load : String -> String -> WebData SurveyResult -> Cmd Msg
load apiUrl id surveyResult =
    Msg.load apiUrl id surveyResult
        |> Task.succeed
        |> Task.perform identity
