module SurveyResult.Path exposing (path)

import Route
import SurveyResult.Model exposing (SurveyResult)
import SurveyResult.Parser as Parser


path : SurveyResult -> String
path surveyResult =
    surveyResult
        |> Parser.id
        |> Route.SurveyResultDetail
        |> Route.toString
