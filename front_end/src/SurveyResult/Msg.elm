module SurveyResult.Msg exposing (Msg(..), fetched, load)

import RemoteData exposing (WebData)
import SurveyResult.Model exposing (SurveyResult)


type Msg
    = Load String String (WebData SurveyResult)
    | Fetched (WebData SurveyResult)


fetched : WebData SurveyResult -> Msg
fetched webData =
    Fetched webData


load : String -> String -> WebData SurveyResult -> Msg
load apiUrl id surveyResult =
    Load apiUrl id surveyResult
