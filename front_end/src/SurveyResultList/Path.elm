module SurveyResultList.Path exposing (path)

import Route


path : String
path =
    Route.SurveyResultList
        |> Route.toString
