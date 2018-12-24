module SurveyResult.Msg exposing (Msg(..))

import RemoteData exposing (WebData)
import SurveyResult.Model exposing (SurveyResult)


type Msg
    = Load String String (WebData SurveyResult)
    | Fetched (WebData SurveyResult)
