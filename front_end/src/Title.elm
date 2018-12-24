module Title exposing (init)

import Language exposing (Language)
import Page.NotFound as NotFound
import RemoteData
import Route exposing (Route)
import SurveyResult
import SurveyResultList


init : Maybe Route -> Language -> String
init route language =
    case route of
        Just Route.SurveyResultList ->
            SurveyResultList.title language RemoteData.NotAsked

        Just (Route.SurveyResultDetail _) ->
            SurveyResult.title language RemoteData.NotAsked

        Nothing ->
            NotFound.title language
